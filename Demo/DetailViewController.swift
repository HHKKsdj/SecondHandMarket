//
//  DetailViewController.swift
//  Demo
//
//  Created by HK on 2021/5/1.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: UIBarButtonItem.Style.done, target: self, action: #selector(back(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "交易", style: .plain, target: self, action: #selector(confirm(sender:)))
        navigationItem.title = "商品详情"
        setUI()
        safeTrack()
    }
    
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    let role = UserDefaults.standard.string(forKey: "role") as String?
    var item = GoodsInfo()
    
    var scrollView : UIScrollView!
    var contentView : UIView!
    var headImage : UIImageView!
    var userName : UILabel!
    var contectLabel : UILabel!
    var contect : UILabel!
    var markLabel : UILabel!
    
    var sortLabel : UILabel!
    var sortText : UILabel!
    var descriptionLabel : UILabel!
    var descriptionText : UILabel!
    var qualityLabel : UILabel!
    var qualityText : UILabel!
    var price : UILabel!
    var priceSign : UILabel!
    var timeLabel : UILabel!
    var imageLabel : UILabel!
    var reportLabel : UILabel!
    
    var bottomView : UIView!
    var shoppingCart : UIButton!
    var shoppingCartTitle : String!
    
    var qualifiledButton : UIButton!
    var unqualifiledButton : UIButton!
    var deleteButton : UIButton!
    var modifyButton : UIButton!
    
    
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
//        contentView.snp.makeConstraints { (make) in
//            make.edges.width.equalTo(scrollView)
//            make.top.equalTo(scrollView)
//            make.height.greaterThanOrEqualTo(scrollView).offset(1)
//        }
        
        headImage = UIImageView.init()

        headImage.clipsToBounds = true
        headImage.contentMode = .scaleAspectFill
        if let url = URL(string: "http://120.77.201.16:8099/user/downPic?uid=\(item.uid)") {
            let placeHolder = UIImage.init(named: "Head")

            headImage.kf.setImage(with: url,placeholder: placeHolder,options: nil,progressBlock: nil,completionHandler: nil)
        }
        contentView.addSubview(headImage)
        headImage.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        headImage.isUserInteractionEnabled = true
        let homePage = UITapGestureRecognizer(target: self, action: #selector(personalHomePage))
        headImage.addGestureRecognizer(homePage)
        
        userName = UILabel.init()
        userName.text = item.nickName
        userName.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(userName)
        userName.snp.makeConstraints{ (make) in
            make.left.equalTo(headImage.snp.right).offset(10)
            make.top.equalTo(headImage.snp.top)
        }
        
        
        markLabel = UILabel.init()
        markLabel.text = "信誉：" + item.sellerEva
        markLabel.font = UIFont.systemFont(ofSize: 12.5)
        markLabel.textColor = UIColor.systemBlue
        contentView.addSubview(markLabel)
        markLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(userName.snp.right).offset(10)
            make.centerY.equalTo(userName.snp.centerY)
        }
        
        contectLabel = UILabel.init()
        contectLabel.text = "联系方式："
        contectLabel.font = UIFont.systemFont(ofSize: 12.5)
        contectLabel.textColor = UIColor.gray
        contentView.addSubview(contectLabel)
        contectLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(userName.snp.left)
            make.top.equalTo(userName.snp.bottom).offset(5)
        }
        
        contect = UILabel.init()
        contect.text = item.contact
        contect.font = UIFont.systemFont(ofSize: 12.5)
        contect.textColor = UIColor.gray
        contentView.addSubview(contect)
        contect.snp.makeConstraints{ (make) in
            make.left.equalTo(contectLabel.snp.right)
            make.top.equalTo(contectLabel.snp.top)
        }
        
        priceSign = UILabel.init()
        priceSign.text = "¥"
        priceSign.font = UIFont.systemFont(ofSize: 20)
        priceSign.textColor = UIColor.red
        contentView.addSubview(priceSign)
        priceSign.snp.makeConstraints { (make) in
            make.top.equalTo(headImage.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
        }
        
        price = UILabel.init()
        price.text = "\(item.price)"
        price.font = UIFont.systemFont(ofSize: 20)
        price.textColor = UIColor.red
        contentView.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.top.equalTo(priceSign.snp.top)
            make.left.equalTo(priceSign.snp.right)
        }
        
        sortLabel = UILabel.init()
        sortLabel.text = "商品分类"
        sortLabel.font = UIFont.systemFont(ofSize: 15)
        sortLabel.textColor = UIColor.gray
        contentView.addSubview(sortLabel)
        sortLabel.snp.makeConstraints { (make) in
            make.top.equalTo(price.snp.bottom).offset(10)
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
                    make.height.equalTo(375)
                }
            } else {
                imageView.snp.makeConstraints { (make) in
                    make.top.equalTo(lastImageView.snp.bottom).offset(1)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview().offset(25)
                    make.height.equalTo(375)
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
        
        reportLabel = UILabel.init()
        reportLabel.text = "⚠️举报"
        reportLabel.font = UIFont.systemFont(ofSize: 15)
        reportLabel.textColor = UIColor.gray
        contentView.addSubview(reportLabel)
        reportLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel)
            make.right.equalToSuperview().offset(-10)
        }
        reportLabel.isUserInteractionEnabled = true
        let report = UITapGestureRecognizer(target: self, action: #selector(report(sender:)))
        reportLabel.addGestureRecognizer(report)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
            make.bottom.equalTo(reportLabel.snp.bottom).offset(7.5)
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
        
        shoppingCart = UIButton.init()
//        let title : String!
//        if UserDefaults.standard.string(forKey: "\(item.uid)") != nil {
//            title = "从购物车中删除"
//        } else {
//            title = "加入购物车"
//        }
        shoppingCart.setTitle(shoppingCartTitle, for: .normal)
        shoppingCart.layer.masksToBounds = true
        shoppingCart.layer.cornerRadius = 12
        shoppingCart.addTarget(self,action:#selector(self.addToShoppingCart(sender:)), for: .touchUpInside)
        shoppingCart.layer.backgroundColor = UIColor.systemRed.cgColor
        bottomView.addSubview(shoppingCart)
        shoppingCart.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(5)
        }
        shoppingCart.isHidden = true
        
        qualifiledButton = UIButton.init()
        qualifiledButton.setTitle("合格", for: .normal)
        qualifiledButton.layer.masksToBounds = true
        qualifiledButton.layer.cornerRadius = 12
        qualifiledButton.addTarget(self,action:#selector(self.qualified(sender:)), for: .touchUpInside)
        qualifiledButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        bottomView.addSubview(qualifiledButton)
        qualifiledButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
        }
        qualifiledButton.isHidden = true
        
        unqualifiledButton = UIButton.init()
        unqualifiledButton.setTitle("不合格", for: .normal)
        unqualifiledButton.layer.masksToBounds = true
        unqualifiledButton.layer.cornerRadius = 12
        unqualifiledButton.addTarget(self,action:#selector(self.unqualified(sender:)), for: .touchUpInside)
        unqualifiledButton.layer.backgroundColor = UIColor.systemRed.cgColor
        bottomView.addSubview(unqualifiledButton)
        unqualifiledButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
        }
        unqualifiledButton.isHidden = true
        
        deleteButton = UIButton.init()
        deleteButton.setTitle("删除商品", for: .normal)
        deleteButton.layer.masksToBounds = true
        deleteButton.layer.cornerRadius = 12
        deleteButton.addTarget(self,action:#selector(self.delete(sender:)), for: .touchUpInside)
        deleteButton.layer.backgroundColor = UIColor.systemRed.cgColor
        bottomView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(5)
        }
        deleteButton.isHidden = true
        
        modifyButton = UIButton.init()
        modifyButton.setTitle("修改商品", for: .normal)
        modifyButton.layer.masksToBounds = true
        modifyButton.layer.cornerRadius = 12
        modifyButton.addTarget(self,action:#selector(self.modify(sender:)), for: .touchUpInside)
        modifyButton.layer.backgroundColor = UIColor.systemRed.cgColor
        bottomView.addSubview(modifyButton)
        modifyButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(5)
        }
        modifyButton.isHidden = true
        
        if uid == item.uid && item.status == 1 {
            self.deleteButton.isHidden = false
        } else if uid == item.uid && item.status == -1 {
            self.modifyButton.isHidden = false
        } else if role == "admin" && item.status == 0 {
            self.qualifiledButton.isHidden = false
            self.unqualifiledButton.isHidden = false
        } else if item.status != 11 {
            self.shoppingCart.isHidden = false
        }
        
        
    }
    
    func safeTrack() {
        if item.uid != uid {
            var trackList = [GoodsInfo]()
            let data = UserDefaults.standard.data(forKey: "\(uid! as Int)track")
    //        data = nil
            if data != nil {
                trackList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [GoodsInfo]
            }
            for i in 0 ..< trackList.count {
                if trackList[i] == item {
                    trackList.remove(at: i)
                }
            }
            trackList.append(item)
            let safedata = try? NSKeyedArchiver.archivedData(withRootObject: trackList, requiringSecureCoding: false)
            UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)track")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc func back(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addToShoppingCart(sender:UIButton) {
        var safedList = [GoodsInfo]()
        let getdata = UserDefaults.standard.data(forKey: "\(uid! as Int)shoppingCart")
                
        if getdata != nil {
            safedList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(getdata!) as! [GoodsInfo]
        }

        if UserDefaults.standard.string(forKey: "\(uid! as Int)+\(item.gid)") == nil {
            UserDefaults.standard.set("\(item.gid)", forKey: "\(uid! as Int)+\(item.gid)")
//            navigationItem.rightBarButtonItem!.image = UIImage(systemName: "cart.fill")
            shoppingCart.setTitle("从购物车中删除", for: .normal)
            safedList.append(item)
        } else {
            UserDefaults.standard.removeObject(forKey: "\(uid! as Int)+\(item.gid)")
            shoppingCart.setTitle("加入购物车", for: .normal)
            for i in 0...safedList.count {
                if safedList[i].gid == item.gid {
                    safedList.remove(at: i)
                    break
                }
            }
        }

        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: safedList, requiringSecureCoding: false)
        
        UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)shoppingCart")
        UserDefaults.standard.synchronize()
    }
    
    @objc func personalHomePage (sender:UITapGestureRecognizer) {
        let personalVC = PersonViewController()

        personalVC.username = item.nickName
        personalVC.contact = item.contact
        personalVC.uid = item.uid
        personalVC.sellerEva = item.sellerEva
        let naviVC = UINavigationController(rootViewController: personalVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true, completion: nil)
    }
    
    @objc func qualified (sender:UIButton) {
        AdminNetwork.shared.PassGoodsRequest(gid: item.gid) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            if content.code == 200 {
                self.success()
            }
        }
    }
    @objc func unqualified (sender:UIButton) {
        let alert = UIAlertController(title: "商品不合格", message: "请输入理由", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "不合格理由"
        }
        let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
            let reason = alert.textFields!.first!
 
            AdminNetwork.shared.DeleteGoodsRequest(gid: self.item.gid,reason:reason.text!) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                if content.code == 200 {
                    self.success()
                }
            }
        })
        let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
            
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func delete (sender:UIButton) {
        GoodsNetwork.shared.DeleteGoodsRequest(gid: item.gid) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            if content.code == 200 {
                self.success()
                self.deleteButton.isHidden = true
                self.modifyButton.isHidden = false
            }
        }
    }
    
    @objc func modify (sender:UIButton) {
        let sortList : [String] = ["书籍","鞋包","电器","电脑配件","家纺","生活百货","运动用品","手机配件","交通工具","其他"]
        let modifyVC = ModifyViewController()
        for i in 0...9 {
            if sortList[i] == sortText.text {
                modifyVC.pick = i
            } else {
                modifyVC.pick = 9
            }
        }
        modifyVC.contact = contect.text
        modifyVC.descrip = descriptionText.text
        modifyVC.price = price.text
        modifyVC.quality = qualityText.text
        modifyVC.gid = item.gid
        let naviVC = UINavigationController(rootViewController: modifyVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)

    }
    
    @objc func report (sender:UITapGestureRecognizer) {

        let alert = UIAlertController(title: "举报此商品", message: "请输入理由", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "举报理由"
        }
        let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
            let reason = alert.textFields!.first!
            self.reportGood(reportReason: reason.text!)
        })
        let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
            
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func success() {
        let alter = UIAlertController(title: "操作成功", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        alter.addAction(action)
        self.present(alter, animated: true, completion: nil)
        
    }
    
    func reportGood(reportReason:String) {
        
        GoodsNetwork.shared.ReportGoodRequest(gid: item.gid,reason:reportReason) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            if content.code == 200 {
                let alter = UIAlertController(title: "操作成功", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                })
                alter.addAction(action)
                self.present(alter, animated: true, completion: nil)
            }
        }
    }
    
    @objc func confirm (sender:UIButton) {
        var message = ""
        if uid == item.uid {
            message = "请输入自定义口令，并告知买家。\n（确认后将完成订单，请谨慎确认！）"
        } else {
            message = "请输入卖家口令。\n（确认后将完成订单，请谨慎确认！）"
        }

        let alert = UIAlertController(title: "商品交易", message: message, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "请输入口令"
        }
        let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
            let key = alert.textFields!.first!
            if self.uid == self.item.uid {
                self.setKey(key: key.text!)
            } else {
                self.checkKey(key: key.text!)
            }

        })
        let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in

        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setKey(key:String) {
        GoodsNetwork.shared.SetBuyCodeRequest(gid: item.gid,buyCode: key) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            let title : String!
            var action = UIAlertAction.init()
            if content.code == 200 {
                title = content.msg
                action = UIAlertAction(title: "确定", style: .default, handler: {_ in
//                    self.presentEvaluation()
                })
            } else {
                title = content.msg
                action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                })
            }
            let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkKey(key:String) {
        self.presentEvaluation(oid: 10)
//        OrderNetwork.shared.BuyRequest(gid: item.gid,buyCode: key) { (error,info) in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let content = info else {
//                print("nil")
//                return
//            }
//            let title : String!
//            var action = UIAlertAction.init()
//            if content.code == 200 {
//                title = content.msg
//                action = UIAlertAction(title: "确定", style: .default, handler: {_ in
//                    self.presentEvaluation(oid: content.oid)
//                })
//            } else {
//                title = content.msg
//                action = UIAlertAction(title: "确定", style: .default, handler: {_ in
//                })
//            }
//            let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
//            alert.addAction(action)
//            self.present(alert, animated: true, completion: nil)
//        }

    }
    
    func presentEvaluation(oid:Int) {
        let evaluationVC = EvaluationViewController()
        evaluationVC.oid = oid
        let naviVC = UINavigationController(rootViewController: evaluationVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
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
