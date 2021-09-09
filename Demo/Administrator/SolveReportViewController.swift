//
//  SolveReportViewController.swift
//  Demo
//
//  Created by HK on 2021/5/9.
//

import UIKit

class SolveReportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "处理举报"
        // Do any additional setup after loading the view.
        setUI()
    }
    
    var item = GoodsInfo()
    var reportId : Int!
    
    var reason : String!
    
    var scrollView : UIScrollView!
    var contentView : UIView!
    
    var contect : UILabel!
    
    var reasonLabel : UILabel!
    var reasonText : UILabel!
    
    var sortLabel : UILabel!
    var sortText : UILabel!
    var descriptionLabel : UILabel!
    var descriptionText : UILabel!
    var qualityLabel : UILabel!
    var qualityText : UILabel!
    var price : UILabel!
    var timeLabel : UILabel!
    var imageLabel : UILabel!
    
    var bottomView : UIView!
    
    var successButton : UIButton!
    var failButton : UIButton!
    
    func setUI() {
        setBottomView()
        
        scrollView = UIScrollView.init()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
//            make.bottom.equalToSuperview().offset(-5)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        reasonLabel = UILabel.init()
        reasonLabel.text = "举报理由"
        reasonLabel.font = UIFont.systemFont(ofSize: 15)
        reasonLabel.textColor = UIColor.gray
        contentView.addSubview(reasonLabel)
        reasonLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        reasonText = UILabel.init()
        reasonText.text = reason
        reasonText.numberOfLines = 0
        reasonText.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(reasonText)
        reasonText.snp.makeConstraints { (make) in
            make.top.equalTo(reasonLabel.snp.bottom)
            make.left.equalTo(reasonLabel.snp.right).offset(5)
        }
        
        
        price = UILabel.init()
        price.text = "¥\(item.price)"
        price.font = UIFont.systemFont(ofSize: 20)
        price.textColor = UIColor.red
        contentView.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.top.equalTo(reasonText.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
        }
        
        contect = UILabel.init()
        contect.text = "联系方式：\(item.contact)"
        contect.font = UIFont.systemFont(ofSize: 12.5)
        contect.textColor = UIColor.gray
        contentView.addSubview(contect)
        contect.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(price.snp.bottom).offset(10)
        }
        
        sortLabel = UILabel.init()
        sortLabel.text = "商品分类"
        sortLabel.font = UIFont.systemFont(ofSize: 15)
        sortLabel.textColor = UIColor.gray
        contentView.addSubview(sortLabel)
        sortLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contect.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        sortText = UILabel.init()
        sortText.text = item.label
        sortText.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(sortText)
        sortText.snp.makeConstraints { (make) in
            make.top.equalTo(sortLabel.snp.bottom)
            make.left.equalTo(sortLabel.snp.right).offset(5)
        }
        
        descriptionLabel = UILabel.init()
        descriptionLabel.text = "商品描述"
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = UIColor.gray
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sortText.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
        }
        
        descriptionText = UILabel.init()
        descriptionText.text = item.descrip
        descriptionText.font = UIFont.systemFont(ofSize: 20)
        descriptionText.numberOfLines = 0
        contentView.addSubview(descriptionText)
        descriptionText.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.left.equalTo(descriptionLabel.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        
        qualityLabel = UILabel.init()
        qualityLabel.text = "商品成色"
        qualityLabel.font = UIFont.systemFont(ofSize: 15)
        qualityLabel.textColor = UIColor.gray
        contentView.addSubview(qualityLabel)
        qualityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionText.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        qualityText = UILabel.init()
        qualityText.text = item.quality
        qualityText.font = UIFont.systemFont(ofSize: 20)
        qualityText.numberOfLines = 0
        contentView.addSubview(qualityText)
        qualityText.snp.makeConstraints { (make) in
            make.top.equalTo(qualityLabel.snp.bottom)
            make.left.equalTo(qualityLabel.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        
        imageLabel = UILabel.init()
        imageLabel.text = "商品图片"
        imageLabel.font = UIFont.systemFont(ofSize: 15)
        imageLabel.textColor = UIColor.gray
        contentView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(qualityText.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        var lastImageView : UIImageView!
        lastImageView = UIImageView.init()
        for i in 0..<item.imgNum {
            let imageView : UIImageView!
            imageView = UIImageView.init()
            if let url = URL(string: "http://120.77.201.16:8099/goods/download?gid=\(item.gid)&index=\(i)") {
                imageView.kf.setImage(with: url)
            }
            
//            let image = imageView.image
//            print(image)
            contentView.addSubview(imageView)
            if i == 0 {
                imageView.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLabel.snp.bottom).offset(5)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(25)
                    make.height.equalTo(350)
                }
            } else {
                imageView.snp.makeConstraints { (make) in
                    make.top.equalTo(lastImageView.snp.bottom).offset(1)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(25)
                    make.height.equalTo(350)
                }
            }
            lastImageView = imageView
        }
        
        timeLabel = UILabel.init()
        timeLabel.text = "发布时间：\(item.uploadTime)"
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        timeLabel.textColor = UIColor.gray
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lastImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
            make.bottom.equalTo(timeLabel.snp.bottom).offset(7.5)
        }
    }
    
    func setBottomView() {
        bottomView = UIView.init()
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(75)
        }
        
        successButton = UIButton.init()
        successButton.setTitle("举报成功", for: .normal)
        successButton.layer.masksToBounds = true
        successButton.layer.cornerRadius = 12
        successButton.addTarget(self,action:#selector(self.success(sender:)), for: .touchUpInside)
        successButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        bottomView.addSubview(successButton)
        successButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
        }
        
        failButton = UIButton.init()
        failButton.setTitle("举报失败", for: .normal)
        failButton.layer.masksToBounds = true
        failButton.layer.cornerRadius = 12
        failButton.addTarget(self,action:#selector(self.fail(sender:)), for: .touchUpInside)
        failButton.layer.backgroundColor = UIColor.systemRed.cgColor
        bottomView.addSubview(failButton)
        failButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
        }

    }
    
    @objc func success (sender: UIButton) {
        
        let alert = UIAlertController(title: "举报成功", message: "将下架此商品", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "请输入扣除的信誉分"
        }
        let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
            let num = alert.textFields!.first!
            AdminNetwork.shared.PunishRequest(uid: self.item.uid,score: num.text!, reason: "举报成功") { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                
                if content.code == 200 {
                    self.delete(gid: self.item.gid)
                }
                
            }
            
        })
        let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
            
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func fail (sender: UIButton) {
        solve(reportId: reportId, result: "举报不成功")
    }
    
    func solve(reportId:Int,result:String) {
        AdminNetwork.shared.SolveReportsRequest(reportId: reportId, result: result) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            if content.code == 200 {
                let alert = UIAlertController(title: "操作成功", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    
                })

                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func delete(gid:Int) {
        AdminNetwork.shared.DeleteGoodsRequest(gid:gid,reason:"举报成功") { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            if content.code == 200 {
                self.solve(reportId: self.reportId, result: "举报成功")
            }
        }
    }
    
    @objc func back (sender: UIButton) {
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
