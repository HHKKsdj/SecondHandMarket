//
//  CommentViewCell.swift
//  Demo
//
//  Created by HK on 2021/5/13.
//

import UIKit

class CommentViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var goodsImageView : UIImageView!
    var commentText : UILabel!
    var descripText : UILabel!
    
    
    
    func setUI() {
        goodsImageView = UIImageView.init()
        goodsImageView.clipsToBounds = true
        goodsImageView.contentMode = .scaleAspectFill
        self.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
//            make.top.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        descripText = UILabel.init()
        descripText.font = UIFont.systemFont(ofSize: 20)
        descripText.numberOfLines = 0
        self.addSubview(descripText)
        descripText.snp.makeConstraints { (make) in
            make.left.equalTo(goodsImageView.snp.right).offset(15)
//            make.top.equalTo(goodsImageView.snp.top)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        commentText = UILabel.init()
        commentText.font = UIFont.systemFont(ofSize: 20)
        commentText.numberOfLines = 0
        self.addSubview(commentText)
        commentText.snp.makeConstraints { (make) in
            make.left.equalTo(goodsImageView.snp.right).offset(15)
            make.top.equalTo(descripText.snp.bottom)
            make.height.equalTo(50)
            make.width.equalTo(200)
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
