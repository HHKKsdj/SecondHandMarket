//
//  OrderListViewController.swift
//  Demo
//
//  Created by HK on 2021/5/5.
//

import UIKit

class OrderListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "我的交易"
        // Do any additional setup after loading the view.
        getData(uid: uid!)
        setUI()
    }
    
    let username = UserDefaults.standard.string(forKey: "username") as String?
    let status = UserDefaults.standard.integer(forKey: "status") as Int?
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    
    var page = 0
    var totalPage = 1 {
        didSet {
            getData(uid: uid!)
        }
    }
    
    
    var goodsList = [GoodsInfo]()
    var postedList = [GoodsInfo]()
    var doneList = [GoodsInfo]()
    var waitForPassList = [GoodsInfo]()

    var segment : UISegmentedControl!
    var tableView : UITableView!
    
    var statusText : String!
    
    var refresh : UIRefreshControl!
    
    func setUI()  {
        segment = UISegmentedControl.init(items: ["已发布","已完成","待审核"])
        segment.selectedSegmentIndex = page
        segment.addTarget(self, action: #selector(segmentDidChange(sender:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(segment)
        segment.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(95)
        }
        
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) in
            make.top.equalTo(segment.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.addSubview(refresh)
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
                if self.totalPage != content[0].pages {
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
                        print("\(good.gid)")
                    }
                }
                switch self.page {
                case 0:
                    self.goodsList = self.postedList
                case 1:
                    self.goodsList = self.doneList
                case 2:
                    self.goodsList = self.waitForPassList
                default:
                    print("nil")
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    @objc func refreshData()  {
        goodsList.removeAll()
        getData(uid: uid!)
        refresh.endRefreshing()
    }
    
    @objc func segmentDidChange(sender:UISegmentedControl) {
//        print(sender.selectedSegmentIndex)
        goodsList.removeAll()
        if sender.selectedSegmentIndex == 0 {
            goodsList = postedList
        } else if sender.selectedSegmentIndex == 1 {
            goodsList = doneList
        } else if sender.selectedSegmentIndex == 2 {
            goodsList = waitForPassList
        }
        tableView.reloadData()
    }

    @objc func back(sender:UILabel) {
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

extension OrderListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell",for: indexPath) as! ProductViewCell
        let item = goodsList[indexPath.row]

        if let url = URL(string: "http://120.77.201.16:8099/user/downPic?uid=\(item.uid)") {
            let placeHolder = UIImage.init(named: "Head")
            cell.headImageView.kf.setImage(with: url,placeholder: placeHolder,options: nil,progressBlock: nil,completionHandler: nil)
        }
        let url = URL(string: "http://120.77.201.16:8099/goods/getFirstPic?gid=\(item.gid)")
        cell.goodsImageView.kf.setImage(with: url)

        cell.usernameLabel.text = self.username
        cell.contactLabel.text = "联系方式：" + item.contact
        cell.markLabel.text = "信誉：\(self.status!)"
        cell.titleLabel.text = item.descrip
        cell.priceLabel.text = "¥\(item.price)"
        
        switch item.status {
        case -1:
            statusText = "不合格"
        case 0:
            statusText = "待审核"

        default:
            statusText = "正常"
        }
        cell.statusLabel.text = "商品状态：" + statusText
        cell.statusLabel.isHidden = false
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = goodsList[indexPath.row]
        item.nickName = self.username!
        item.sellerEva = " \(self.status!)"
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

//        goodsList.remove(at: indexPath.row)
//
//        self.tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
            return "删除商品"
        }
    
}
