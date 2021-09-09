//
//  ReportsViewCell.swift
//  Demo
//
//  Created by HK on 2021/5/8.
//

import UIKit

class ReportsViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var goodImageView : UIImageView!
    var descriptionText : UILabel!
    var reasonText : UILabel!
    var statusText : UILabel!
    
    
    func setUI() {
        goodImageView = UIImageView.init()
        goodImageView.clipsToBounds = true
        goodImageView.contentMode = .scaleAspectFill
        self.addSubview(goodImageView)
        goodImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
//            make.top.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        descriptionText = UILabel.init()
        descriptionText.numberOfLines = 0
        descriptionText.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(descriptionText)
        descriptionText.snp.makeConstraints { (make) in
            make.left.equalTo(goodImageView.snp.right).offset(10)
            make.top.equalTo(goodImageView.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        reasonText = UILabel.init()
        reasonText.numberOfLines = 0
        reasonText.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(reasonText)
        reasonText.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionText.snp.bottom).offset(5)
            make.left.equalTo(descriptionText.snp.left)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        statusText = UILabel.init()
        statusText.font = UIFont.systemFont(ofSize: 10)
        statusText.textColor = UIColor.gray
        self.addSubview(statusText)
        statusText.snp.makeConstraints { (make) in
            make.top.equalTo(reasonText.snp.bottom)
            make.right.equalToSuperview().offset(-10)
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
