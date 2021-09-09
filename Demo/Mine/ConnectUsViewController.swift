//
//  MessageDetailViewController.swift
//  Demo
//
//  Created by HK on 2021/5/12.
//

import UIKit

class ConnectUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        // Do any additional setup after loading the view.
        navigationItem.title = "联系我们"
        setUI()
    }
    
    var label1 : UILabel!
    var label2 : UILabel!
    
    func setUI() {
        label1 = UILabel.init()
        label1.text = "客服在线时间：\n周一至周五：8:00-19:00\n周六至周日：9:00-18:00"
        label1.numberOfLines = 0
        self.view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(250)
        }
        label2 = UILabel.init()
        label2.text = "联系方式：\n邮箱：123456745@xx.com\n电话：213—123131233"
        label2.numberOfLines = 0
        self.view.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.centerX.equalTo(label1.snp.centerX)
            make.top.equalTo(label1.snp.bottom).offset(75)
            make.width.equalTo(250)
        }
    }
    


    @objc func back (sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
