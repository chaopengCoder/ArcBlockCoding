//
//  MainController.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit
import RxSwift
import Foundation
import RxDataSources
import JXPhotoBrowser

class MainController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let viewModel = MainViewModel()
    
    fileprivate lazy var iMainTb: UITableView = {
        let tb = UITableView()
        tb.separatorStyle = .none
        tb.estimatedRowHeight = 100
        tb.backgroundColor = .cF4F6F9
        tb.register(MainLinkCell.self)
        tb.register(MainTextCell.self)
        tb.register(MainTextImgCell.self)
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel.loadList()
        bindViews()
    }
    
    fileprivate func setupSubviews() {
        self.title = "首页"
        view.backgroundColor = .red
        view.addSubview(iMainTb)
        iMainTb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func bindViews() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Void, MainModel>> (
            configureCell: { dataSource, tableView, indexPath, model -> UITableViewCell in
                var cell: MainBaseCell!
                switch model.type {
                case .text:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainTextCell
                case .textLink:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainLinkCell
                case .textImg, .img:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainTextImgCell
                }
                cell.model = model
                return cell
        })
        
        viewModel.listData
            .map{ $0.map{ SectionModel(model: Void(), items: [$0]) } }
            .bind(to: iMainTb.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        iMainTb.rx.setDelegate(self).disposed(by: disposeBag)
        
        iMainTb.rx.modelSelected(MainModel.self)
            .subscribe (onNext: { (model) in
                
                switch model.type {
                case .text:
                    print("不用进入详情")
                case .textLink:
                    print("进入webView")
                    let vc = WebController(url: model.link)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .textImg, .img:
                    print("进入详情")
                    let vc = DetailViewController(model: model)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)

    }
}

extension MainController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
