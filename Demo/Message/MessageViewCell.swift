//
//  MessageViewCell.swift
//  Demo
//
//  Created by HK on 2021/4/27.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headImageView : UIImageView!
    var titleLabel : UILabel!
    var contentLabel : UILabel!
    var timeLabel : UILabel!
    
    
    func setUI() {
//        headImageView = UIImageView.init(frame: CGRect(x: 15, y: 15, width: 50, height: 50))
//        headImageView.image = UIImage(named: "Head")
//        headImageView.layer.masksToBounds = true
//        headImageView.layer.cornerRadius = headImageView.frame.size.width/2
//        self.addSubview(headImageView)
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        contentLabel = UILabel.init()
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        timeLabel = UILabel.init()
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = UIColor.gray
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(contentLabel.snp.bottom)
        }
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
