//
//  MainTextImgCell.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit
import Kingfisher

class MainTextImgCell: MainBaseCell {

    override var model: MainModel!{
        didSet {
            updateLayout(model.content)
            iMoreView.isHidden = model.imgUrls.count == 1
            iCoverIv.kf.setImage(with: URL(string: model.imgUrls.first ?? ""), placeholder: UIImage(named: "placeholder"))
        }
    }
    
    fileprivate lazy var iCoverIv: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate lazy var iMoreView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        iContentView.addSubview(iCoverIv)
        
        let iMoreLb = UILabel()
        iMoreLb.textColor = .white
        iMoreLb.text = "更多图片"
        iMoreView.addSubview(iMoreLb)
        iMoreLb.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        iCoverIv.addSubview(iMoreView)
        iMoreView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-10)
        }
    }
    
    fileprivate func updateLayout(_ content: String) {
        if content.isEmpty {
            iContentLb.removeFromSuperview()
            iCoverIv.snp.remakeConstraints { (make) in
                make.top.equalTo(10)
                make.left.equalTo(10)
                make.height.equalTo(180)
                make.right.bottom.equalTo(-10)
            }
        } else {
            iContentLb.attributedText = model.content.attributed
            iContentView.addSubview(iContentLb)
            iContentLb.snp.remakeConstraints { (make) in
                make.right.equalTo(-10)
                make.top.left.equalTo(10)
            }
            
            iCoverIv.snp.remakeConstraints { (make) in
                make.left.equalTo(10)
                make.height.equalTo(180)
                make.right.bottom.equalTo(-10)
                make.top.equalTo(iContentLb.snp.bottom).offset(10)
            }
        }
    }
}
