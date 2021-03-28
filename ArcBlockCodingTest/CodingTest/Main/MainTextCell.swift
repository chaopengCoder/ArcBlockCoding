//
//  MainTextCell.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit

class MainTextCell: MainBaseCell {
    
    override var model: MainModel! {
        didSet {
            iContentLb.attributedText = model.content.attributed
        }
    }

    override func setupSubviews() {
        super.setupSubviews()
        iContentView.addSubview(iContentLb)
        iContentLb.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }

}
