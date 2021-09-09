//
//  MyViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit
import SnapKit

class MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getData(uid: uid!)
        setUI(name: username!, mark: status!)
    }
    let username = UserDefaults.standard.string(forKey: "username") as String?
    let status = UserDefaults.standard.integer(forKey: "status") as Int?
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?

    var headImageView : UIImageView!
    var userNameLabel : UILabel!
    var markLabel : UILabel!
    var orderView : UIView!
    var testButton : UIButton!
    var serviceLabel : UILabel!
    var serviceView : UICollectionView!
    
    let serviceName : [String] = ["浏览历史","历史评价","客服中心","管理模式"]
    
    var goodsList = [GoodsInfo]()
    var postedList = [GoodsInfo]()
    var doneList = [GoodsInfo]()
    var waitForPassList = [GoodsInfo]()
    
    var titleLabel : UILabel!
    var allButton : UIButton!
    var postedButton : UIButton!
    var notDoneButton : UIButton!
    var doneButton : UIButton!
    var waitForPassButton : UIButton!
    
    var totalPage = 1{
        didSet{
            getData(uid: uid!)
        }
    }
    
    func setUI(name:String,mark:Int) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: UIBarButtonItem.Style.done, target: self, action: #selector(setting(sender:)))
        
        headImageView = UIImageView.init(frame: CGRect(x: 15, y: 100, width: 65, height: 65))
        headImageView.image = UIImage(named: "Head")
        headImageView.clipsToBounds = true
        headImageView.contentMode = .scaleAspectFill
        if let url = URL(string: "http://120.77.201.16:8099/user/downPic?uid=\(uid! as Int)") {
            let placeHolder = UIImage.init(named: "Head")
            headImageView.kf.setImage(with: url,placeholder: placeHolder,options: nil,progressBlock: nil,completionHandler: nil)
        }
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2
        self.view.addSubview(headImageView)
        
        userNameLabel = UILabel.init(frame: CGRect(x: 100, y: 100, width: 150, height: 35))
        userNameLabel.text = name
        userNameLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(userNameLabel)
        markLabel = UILabel.init(frame: CGRect(x: 275, y: 110, width: 100, height: 35))
        markLabel.text = "信誉积分：\(mark)"
        markLabel.textAlignment = .center
        markLabel.font = UIFont.systemFont(ofSize: 12)
        markLabel.textColor = UIColor.white
        markLabel.backgroundColor = UIColor.link
        markLabel.layer.masksToBounds = true
        markLabel.layer.cornerRadius = 15
        self.view.addSubview(markLabel)

        orderView = UIView.init()
//        orderView.frame = CGRect.zero
        orderView.frame = CGRect(x: 10, y: 175, width: self.view.frame.size.width-20, height: 125)
        orderView.backgroundColor = UIColor.white
        orderView.layer.borderWidth = 0.25
        orderView.layer.borderColor = UIColor.black.cgColor
        orderView.layer.cornerRadius = 15
        orderView.layer.masksToBounds = true
        self.view.addSubview(orderView)
        orderView.snp.makeConstraints { (make) in
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        setOrderView()
        
        serviceLabel = UILabel.init(frame: CGRect.zero)
        serviceLabel.text = "功能服务"
        serviceLabel.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(serviceLabel)
        serviceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(orderView.snp.bottom).offset(10)
        }
        setColletionView()
    }
    
    func setOrderView()  {
        titleLabel = UILabel.init(frame: CGRect(x: 8, y: 5, width: 100, height: 30))
        titleLabel.text = "我的交易"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        orderView.addSubview(titleLabel)
        allButton = UIButton.init(frame: CGRect(x: 275, y: 5, width: 100, height: 30))
        allButton.setTitle("查看全部 >", for: .normal)
        allButton.setTitleColor(.gray, for: .normal)
        allButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        allButton.addTarget(self, action: #selector(posted(sender:)), for: .touchUpInside)
        orderView.addSubview(allButton)
        
        postedButton = UIButton.init()
        postedButton.titleLabel?.lineBreakMode = .byWordWrapping
        postedButton.setTitle("    \(goodsList.count)\n已发布", for: .normal)
        postedButton.setTitleColor(.gray, for: .normal)
        postedButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.5)
        postedButton.addTarget(self, action: #selector(posted(sender:)), for: .touchUpInside)
        orderView.addSubview(postedButton)
        postedButton.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview().offset(10)
            make.centerX.equalToSuperview().offset(-125)
        }
        
        doneButton = UIButton.init()
        doneButton.titleLabel?.lineBreakMode = .byWordWrapping
        doneButton.setTitle("    \(doneList.count)\n已完成", for: .normal)
        doneButton.setTitleColor(.gray, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.5)
        doneButton.addTarget(self, action: #selector(done(sender:)), for: .touchUpInside)
        orderView.addSubview(doneButton)
        doneButton.snp.makeConstraints{ (make) in
            make.top.equalTo(postedButton.snp.top)
            make.centerX.equalToSuperview()
        }
        
        waitForPassButton = UIButton.init()
        waitForPassButton.titleLabel?.lineBreakMode = .byWordWrapping
        waitForPassButton.setTitle("    \(waitForPassList.count)\n待审核", for: .normal)
        waitForPassButton.setTitleColor(.gray, for: .normal)
        waitForPassButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.5)
        waitForPassButton.addTarget(self, action: #selector(waitForPass(sender:)), for: .touchUpInside)
        orderView.addSubview(waitForPassButton)
        waitForPassButton.snp.makeConstraints{ (make) in
            make.top.equalTo(postedButton.snp.top)
            make.centerX.equalToSuperview().offset(125)
        }
    }
    
    func setColletionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 50)
        layout.minimumLineSpacing = 5
        serviceView = UICollectionView(frame: CGRect(x: 20, y: 350, width: self.view.frame.size.width - 40, height: 450), collectionViewLayout: layout)
        serviceView.register(ServiceViewCell.self, forCellWithReuseIdentifier: "ServiceViewCell")
        serviceView.delegate = self
        serviceView.dataSource = self
        serviceView.backgroundColor = UIColor.white
        self.view.addSubview(serviceView)
//        serviceView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
//            make.width.equalToSuperview().offset(-20)
//        }

    }
    
    @objc func setting(sender:UIButton) {
        let settingVC = SettingViewController()
        let naviVC = UINavigationController(rootViewController: settingVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true, completion: nil)
    }
    
    func getData(uid:Int) {
        self.postedList.removeAll()
        self.doneList.removeAll()
        self.waitForPassList.removeAll()
        for i in 1...totalPage {
            GoodsNetwork.shared.PersonalGoodsListRequest(uid: uid,pageNum: i) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                if content.count != 0 && self.totalPage != content[0].pages {
                    self.totalPage = content[0].pages
                }
                for good in content {
                    self.postedList.append(good)
                    switch good.status {
                    case 0:
                        self.waitForPassList.append(good)
                    case 1:
                        self.doneList.append(good)
                    default:
                        print(good.gid)
                    }
                }
                self.postedButton.setTitle("    \(self.postedList.count)\n已发布", for: .normal)
                self.doneButton.setTitle("    \(self.doneList.count)\n已完成", for: .normal)
                self.waitForPassButton.setTitle("    \(self.waitForPassList.count)\n待审核", for: .normal)
            }
        }
        
        
    }
    
    @objc func posted (sender: UIButton){
        let page = 0
        orderList(page: page)
    }
    @objc func done (sender: UIButton){
        let page = 1
        orderList(page: page)
    }
    @objc func waitForPass (sender: UIButton){
        let page = 2
        orderList(page: page)
    }
    
    func orderList(page:Int) {
        let orderListVC = OrderListViewController()
        orderListVC.page = page
        let naviVC = UINavigationController(rootViewController: orderListVC)
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


extension MineViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceViewCell", for: indexPath) as! ServiceViewCell
        let data = serviceName[indexPath.row]
        cell.imageView.image = UIImage(named: "\(data)")
        cell.titleLabel.text = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let trackVC = TrackViewController()
            let naviVC = UINavigationController(rootViewController: trackVC)
            naviVC.modalPresentationStyle = .fullScreen
            present(naviVC, animated: true, completion: nil)
        case 1:
            let commentVC = CommentViewController()
            let naviVC = UINavigationController(rootViewController: commentVC)
            naviVC.modalPresentationStyle = .fullScreen
            present(naviVC, animated: true, completion: nil)
        case 2:
            let connectVC = ConnectUsViewController()
            let naviVC = UINavigationController(rootViewController: connectVC)
            naviVC.modalPresentationStyle = .fullScreen
            present(naviVC, animated: true, completion: nil)
        case 3:
            adminView()
        default:
            print("nil")
        }

    }
    
    func adminView() {
        let role = UserDefaults.standard.string(forKey: "role")
        let alterTitle : String!
        if role == "admin" {
            alterTitle = "进入管理模式"
        } else {
            alterTitle = "您不是管理员"
        }
        
        let alter = UIAlertController(title: alterTitle, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
            if role == "admin" {
                let adminVC = AdministratorViewController()
                let naviVC = UINavigationController(rootViewController: adminVC)
                naviVC.modalPresentationStyle = .fullScreen
                self.present(naviVC, animated: true, completion: nil)
            }
        })
        alter.addAction(action)
        self.present(alter, animated: true, completion: nil)
    }
}
