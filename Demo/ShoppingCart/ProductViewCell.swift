//
//  ProductViewCell.swift
//  Demo
//
//  Created by HK on 2021/4/27.
//

import UIKit
import Kingfisher

class ProductViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item = GoodsInfo()
    
    var headImageView : UIImageView!
    var usernameLabel : UILabel!
    var contactLabel : UILabel!
    var markLabel : UILabel!
    
    var statusLabel : UILabel!
    
    var goodsImageView : UIImageView!
    
    var titleLabel : UILabel!
    var priceLabel : UILabel!
    
    var timeLabel : UILabel!
        
    
    func setUI() {
        headImageView = UIImageView.init(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        headImageView.clipsToBounds = true
        headImageView.contentMode = .scaleAspectFill
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2
        self.addSubview(headImageView)
        
        usernameLabel = UILabel.init()
        usernameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(10)
            make.top.equalTo(headImageView.snp.top)
        }
        
        markLabel = UILabel.init()
        markLabel.font = UIFont.systemFont(ofSize: 10)
        markLabel.textColor = UIColor.systemBlue
        self.addSubview(markLabel)
        markLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel.snp.right).offset(10)
            make.bottom.equalTo(usernameLabel.snp.bottom)
        }
        
        contactLabel = UILabel.init()
        contactLabel.font = UIFont.systemFont(ofSize: 10)
        contactLabel.textColor = UIColor.gray
        self.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel.snp.left)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
        
        goodsImageView = UIImageView.init()
        goodsImageView.clipsToBounds = true
        goodsImageView.contentMode = .scaleAspectFill
        self.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.left)
            make.top.equalTo(contactLabel.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(goodsImageView.snp.right).offset(15)
            make.top.equalTo(goodsImageView.snp.top)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        priceLabel = UILabel.init()
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = UIColor.red
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        statusLabel = UILabel.init()
        statusLabel.font = UIFont.systemFont(ofSize: 10)
        statusLabel.textColor = UIColor.gray
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints{ (make) in
            make.bottom.equalTo(contactLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
        }
        statusLabel.isHidden = true
        
        timeLabel = UILabel.init()
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = UIColor.gray
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.right.equalToSuperview().offset(-5)
        }
        timeLabel.isHidden = true
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
