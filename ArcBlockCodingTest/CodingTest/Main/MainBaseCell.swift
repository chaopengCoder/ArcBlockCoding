//
//  MainTextCell.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import SnapKit

class MainBaseCell: UITableViewCell {
    
    var model: MainModel!
    
    // 文本内容
    lazy var iContentLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 16)
        return lb
    }()
    
    // 内容容器
    lazy var iContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .cF4F6F9
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(iContentView)
        iContentView.layer.cornerRadius = 6
        iContentView.layer.backgroundColor = iContentView.backgroundColor?.cgColor
        iContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
}
