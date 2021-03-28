//
//  DetailViewController.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit
import RxCocoa
import RxSwift
import JXPhotoBrowser

class DetailViewController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate lazy var iFlowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        flow.itemSize = CGSize(width: (UIAdapter.Width - 40) / 3, height: (UIAdapter.Width - 40) / 3)
        return flow
    }()
    
    fileprivate lazy var iDetailClv: UICollectionView = {
        let clv = UICollectionView(frame: .zero, collectionViewLayout: iFlowLayout)
        clv.register(DetailImageCell.self)
        clv.backgroundColor = .white
        clv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        return clv
    }()
    
    fileprivate lazy var iContentLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 18)
        return lb
    }()
    
    fileprivate let model: MainModel
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        setupSubviews()
        bindViews()
    }
    
    fileprivate func setupSubviews() {
        view.backgroundColor = .white
        if !model.content.isEmpty {
            view.addSubview(iContentLb)
            iContentLb.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(UIAdapter.NavigationHeight + 20)
            }
        }
        
        view.addSubview(iDetailClv)
        iDetailClv.snp.makeConstraints { (make) in
            if model.content.isEmpty {
                make.top.equalToSuperview()
            } else {
                make.top.equalTo(iContentLb.snp.bottom).offset(10)
            }
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.bottom.equalTo(-10)
        }
    }
    
    fileprivate func bindViews() {
        
        if !model.content.isEmpty {
            iContentLb.text = model.content
        }
        
        Observable.just(model.imgUrls)
            .bind(to: iDetailClv.rx.items) { (clv, row, url) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = clv.dequeueReusableCell(forIndexPath: indexPath) as DetailImageCell
                cell.imageUrl = url
                return cell
            }
            .disposed(by: disposeBag)
        
        iDetailClv.rx.itemSelected
            .subscribe (onNext: { (indexPath) in
                let browser = JXPhotoBrowser()
                browser.numberOfItems = {
                    self.model.imgUrls.count
                }
                
                browser.cellClassAtIndex = { _ in
                    LoadingImageCell.self
                }
                
                browser.reloadCellAtIndex = { context in
                    let browserCell = context.cell as? LoadingImageCell
                    let collectionPath = IndexPath(item: context.index, section: indexPath.section)
                    let cell = self.iDetailClv.cellForItem(at: collectionPath) as? DetailImageCell
                    let placeholder = cell?.iCoverImg.image
                    browserCell?.reloadData(placeholder: placeholder, urlString: self.model.imgUrls[context.index])
                }
                
                browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: { index -> UIView? in
                    let path = IndexPath(item: index, section: indexPath.section)
                    let cell = self.iDetailClv.cellForItem(at: path) as? DetailImageCell
                    return cell?.iCoverImg
                })
                browser.pageIndex = indexPath.item
                browser.show()
            })
            .disposed(by: disposeBag)

    }
}

/// 加上进度环的Cell
class LoadingImageCell: JXPhotoBrowserImageCell {
    /// 进度环
    let progressView = JXPhotoBrowserProgressView()
    
    override func setup() {
        super.setup()
        addSubview(progressView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    func reloadData(placeholder: UIImage?, urlString: String?) {
        progressView.progress = 0
        let url = urlString.flatMap { URL(string: $0) }
        
        imageView.kf.setImage(with: url, placeholder: placeholder) { [weak self] (received, total) in
            guard let `self` = self else { return }
            if total > 0 {
                self.progressView.progress = CGFloat(received) / CGFloat(total)
            }
        } completionHandler: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(_):
                self.progressView.progress = 1
            case .failure(_):
                self.progressView.progress = 0
            }
            self.setNeedsLayout()
        }
    }
}

/// 加载进度环
open class JXPhotoBrowserProgressView: UIView {
    
    /// 进度
    open var progress: CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                self.fanshapedLayer.path = self.makeProgressPath(self.progress).cgPath
                if self.progress >= 1.0 || self.progress < 0.01 {
                    self.isHidden = true
                } else {
                    self.isHidden = false
                }
            }
        }
    }
    
    /// 外边界
    private var circleLayer: CAShapeLayer!
    
    /// 扇形区
    private var fanshapedLayer: CAShapeLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        if self.frame.size.equalTo(.zero) {
            self.frame.size = CGSize(width: 50, height: 50)
        }
        setupUI()
        progress = 0
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.clear
        let strokeColor = UIColor(white: 1, alpha: 0.8).cgColor
        
        circleLayer = CAShapeLayer()
        circleLayer.strokeColor = strokeColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.path = makeCirclePath().cgPath
        layer.addSublayer(circleLayer)
        
        fanshapedLayer = CAShapeLayer()
        fanshapedLayer.fillColor = strokeColor
        layer.addSublayer(fanshapedLayer)
    }
    
    private func makeCirclePath() -> UIBezierPath {
        let arcCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: arcCenter, radius: 25, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 2
        return path
    }
    
    private func makeProgressPath(_ progress: CGFloat) -> UIBezierPath {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.midY - 2.5
        let path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: CGPoint(x: bounds.midX, y: center.y - radius))
        path.addArc(withCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 2 + CGFloat.pi * 2 * progress, clockwise: true)
        path.close()
        path.lineWidth = 1
        return path
    }
}
