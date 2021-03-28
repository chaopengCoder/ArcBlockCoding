//
//  MainLinkCell.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit

class MainLinkCell: MainBaseCell {

    override var model: MainModel! {
        didSet {
            iLinkLb.text = model.link
            iContentLb.attributedText = model.content.attributed
        }
    }
    
    fileprivate lazy var iLinkLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.textColor = .c46A3FF
        lb.font = .systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return lb
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        iContentView.addSubview(iContentLb)
        iContentLb.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.left.equalTo(10)
        }
        
        let iLinkView = UIView()
        iLinkView.backgroundColor = .cF4F6F9
        iLinkView.layer.cornerRadius = 4
        iLinkView.layer.backgroundColor = iLinkView.backgroundColor?.cgColor
        
        let iLinkIv = UIImageView(image: UIImage(named: "links_placeholder"))
        iContentView.addSubview(iLinkView)
        iLinkView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.right.equalTo(-10)
            make.top.equalTo(iContentLb.snp.bottom).offset(10)
        }

        iLinkView.addSubview(iLinkIv)
        iLinkIv.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.top.left.bottom.equalToSuperview()
        }

        iLinkView.addSubview(iLinkLb)
        iLinkLb.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(iLinkIv)
            make.left.equalTo(iLinkIv.snp.right).offset(10)
        }
    }

}
