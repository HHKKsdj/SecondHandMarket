//
//  TableViewCell.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title : UILabel!
    
    func setUI() {
        title = UILabel.init()
        self.addSubview(title)
        title.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(50)
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
