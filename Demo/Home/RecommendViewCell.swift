//
//  RecommendViewCell.swift
//  Demo
//
//  Created by HK on 2021/4/24.
//

import UIKit

class RecommendViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var priceLabel : UILabel!
    var imageView: UIImageView!
    var sectionLabel : UILabel!
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        imageView = UIImageView.init(frame: CGRect.zero)
//        imageView = UIImageView()
//        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width)
        imageView.frame = CGRect(x: 0, y: 0, width: 175, height: 175)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        imageView.contentMode = .center
        addSubview(imageView)
//        imageView.snp.makeConstraints{ (make) in
//            make.centerX.equalToSuperview()
////            make.width.equalToSuperview()
////            make.height.equalTo(make.width as! ConstraintRelatableTarget)
//        }
        
        priceLabel = UILabel(frame: CGRect.zero)
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = UIColor.red
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(descriptionLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(10)
        }
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(priceLabel.snp.top)
            make.centerX.equalTo(imageView.snp.centerX)
            make.width.equalToSuperview()
        }
        
        sectionLabel = UILabel.init()
        sectionLabel.font = UIFont.systemFont(ofSize: 10)
        sectionLabel.textColor = UIColor.gray
        self.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints{ (make) in
            make.bottom.equalTo(priceLabel.snp.bottom)
            make.right.equalToSuperview().offset(-10)
        }
//        sectionLabel.isHidden = true
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
