//
//  DetailImageCell.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit
import Kingfisher

class DetailImageCell: UICollectionViewCell {
    
    var imageUrl = "" {
        didSet {
            iCoverImg.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"))
        }
    }
    
    lazy var iCoverImg: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iCoverImg)
        iCoverImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
