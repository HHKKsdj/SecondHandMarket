//
//  ServiceViewCell.swift
//  Demo
//
//  Created by HK on 2021/4/19.
//

import UIKit

class ServiceViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var imageView: UIImageView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        imageView = UIImageView()
//        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width)
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(20)
            make.height.equalTo(30)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
