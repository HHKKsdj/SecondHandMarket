//
//  HeaderViewCell.swift
//  Demo
//
//  Created by HK on 2021/4/24.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var imageView: UIImageView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width)
        imageView.contentMode = .scaleAspectFit
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.gray
        titleLabel.textAlignment = .center
        addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
