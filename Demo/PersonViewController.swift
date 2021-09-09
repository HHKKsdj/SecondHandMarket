//
//  PersonViewController.swift
//  Demo
//
//  Created by HK on 2021/5/2.
//

import UIKit
import SnapKit
import ESPullToRefresh

class PersonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "个人主页"
        getData()
        setUI()
    }
    
    var goodsList = [GoodsInfo](){
        didSet{
//            self.viewWillAppear(true)
            self.goodsView.reloadData()
        }
    }
    
    var page = 1
    var totalPage = 1
    
    var username : String!
    var uid : Int!
    var contact : String!
    var sellerEva : String!
    
    
    var headImage : UIImageView!
    var usernameLabel : UILabel!
    var contactLabel : UILabel!
    var markLabel : UILabel!
    var goodsView : UICollectionView!
    
    
    func setUI() {
//        print(username)
//        print(contact)
//        print(uid)
//        headImage = UIImageView.init()
        headImage = UIImageView.init(frame: CGRect(x: 15, y: 100, width: 65, height: 65))
        let resize = CGSize(width: 65, height: 65)
        headImage.image = UIImage(named: "Head")?.reSizeImage(reSize: resize)
        if let url = URL(string: "http://120.77.201.16:8099/user/downPic?uid=\(uid as Int)") {
            let placeHolder = UIImage.init(named: "Head")
        
            headImage.kf.setImage(with: url,placeholder: placeHolder,options: nil,progressBlock: nil,completionHandler: nil)
        }
        headImage.clipsToBounds = true
        headImage.contentMode = .scaleAspectFill
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.size.width/2
        self.view.addSubview(headImage)
//        headImage.snp.makeConstraints{ (make) in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.equalTo(65)
//            make.height.equalTo(65)
//        }
        
        usernameLabel = UILabel.init(frame: CGRect(x: 90, y: 100, width: 100, height: 30))
        usernameLabel.text = username
        usernameLabel.textColor = UIColor.black
        usernameLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(usernameLabel)
//        usernameLabel.snp.makeConstraints{ (make) in
//            make.left.equalTo(headImage.snp.right).offset(15)
//            make.top.equalTo(headImage.snp.top)
//        }
        
        markLabel = UILabel.init(frame: CGRect(x: 200, y: 100, width: 100, height: 30))
        markLabel.text = "信誉：" + sellerEva
        markLabel.font = UIFont.systemFont(ofSize: 15)
        markLabel.textColor = UIColor.systemBlue
        self.view.addSubview(markLabel)
//        markLabel.snp.makeConstraints{ (make) in
//            make.left.equalTo(usernameLabel.snp.right).offset(15)
//            make.centerX.equalTo(usernameLabel.snp.centerX)
//        }
        
        contactLabel = UILabel.init()
        contactLabel.text = "联系方式：" + contact
        contactLabel.font = UIFont.systemFont(ofSize: 15)
        contactLabel.textColor = UIColor.gray
        self.view.addSubview(contactLabel)
        contactLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(usernameLabel.snp.left)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
        
        setGoodsView()
    }
    
    func setGoodsView() {
        let layout = UICollectionViewFlowLayout()
        goodsView = GoodsTool().collectionview(layout: layout)
        goodsView.delegate = self
        goodsView.dataSource = self
        self.view.addSubview(goodsView)
        goodsView.snp.makeConstraints { (make) in
            make.top.equalTo(headImage.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.goodsView.es.addPullToRefresh {
            [unowned self] in
            self.page = 1
            self.goodsList.removeAll()
            self.getData()
            self.goodsView.es.stopPullToRefresh()

        }
        self.goodsView.es.addInfiniteScrolling {
            [unowned self] in
            if self.page + 1 <= self.totalPage {
                self.page += 1
                self.getData()
                self.goodsView.es.stopLoadingMore()
            } else {
                self.goodsView.es.noticeNoMoreData()
            }
        }
    }
    
    func getData() {
        GoodsNetwork.shared.PersonalGoodsListRequest(uid: uid,pageNum: page) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            for item in content {
                self.goodsList.append(item)
            }
            self.totalPage = content[0].pages
            self.goodsView.reloadData()
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

extension PersonViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GoodsTool().viewCell(collectionView: collectionView, item: goodsList[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = goodsList[indexPath.row]
        item.sellerEva = sellerEva
        item.nickName = username
        item.contact = contact
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
    }
}
