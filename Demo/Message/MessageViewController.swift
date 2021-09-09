//
//  GroupViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit
import ESPullToRefresh

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let data = UserDefaults.standard.data(forKey: "\(self.uid)message")
        if data != nil {
            self.messageList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [MessageInfo]
        }
        getData()
        setUI()
        // Do any additional setup after loading the view.
    }
    let username = UserDefaults.standard.string(forKey: "username") as String?
    let status = UserDefaults.standard.integer(forKey: "status") as Int?
    var messageView : UITableView!
    var messageList = [MessageInfo]()
    let uid = UserDefaults.standard.integer(forKey: "uid")
    var gid : String!
    var refresh : UIRefreshControl!
    
    func setUI() {
        messageView = UITableView.init(frame: CGRect.zero)
        messageView.dataSource = self
        messageView.delegate = self
        messageView.register(MessageViewCell.self, forCellReuseIdentifier: "MessageViewCell")
        self.view.addSubview(messageView)
        messageView.snp.makeConstraints {  (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.messageView.addSubview(refresh)
    }
    
    func getData() {
        
        AccountNetwork.shared.GetMessagesRequest() { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            for message in content {
                self.messageList.append(message)
            }
            let safedata = try? NSKeyedArchiver.archivedData(withRootObject: self.messageList, requiringSecureCoding: false)
            UserDefaults.standard.set(safedata, forKey: "\(self.uid)message")
            UserDefaults.standard.synchronize()
            
            self.messageList = self.messageList.reversed()
            
            self.messageView.reloadData()
        }
    }
    
    func presentDetail(data:String) {
        let needle1: Character = "{"
        if let subIndex = data.firstIndex(of:needle1) {
            let sub = data.distance(from:data.startIndex, to: subIndex)
            let needle2: Character = "}"
            if let endIndex = data.firstIndex(of:needle2) {
                let subIndex: String.Index = data.index(data.startIndex, offsetBy:sub+1)
                let gid = data[subIndex..<endIndex]
                GoodsNetwork.shared.GetAnGoodRequest(gid: String(gid)) { (error,info) in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let content = info else {
                        print("nil")
                        return
                    }
                    let item = content
                    item.nickName = self.username!
                    item.sellerEva = "\(self.status!)"
                    let naviVC = GoodsTool().presentDetail(item:item)
                    self.present(naviVC, animated: true, completion: nil)
                }
            }
            else {
                print("Not found")
            }
        }
        else {
            print("Not found")
        }
    }
    
    @objc func refreshData()  {
        let data = UserDefaults.standard.data(forKey: "\(self.uid)message")
        if data != nil {
            self.messageList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [MessageInfo]
        }
        getData()
        refresh.endRefreshing()
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

extension MessageViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell",for: indexPath) as! MessageViewCell
//        cell.headImageView.image = UIImage(named: "Head")
        cell.titleLabel.text = message.source
        cell.contentLabel.text = message.data
        cell.timeLabel.text = message.time
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messageList[indexPath.row]

        switch message.source {
        case "审核消息":
            self.presentDetail(data: message.data)
        case "订单消息":
            self.presentDetail(data: message.data)
        case "商品消息":
            self.presentDetail(data: message.data)
        default:
            let connectVC = ConnectUsViewController()
            let naviVC = UINavigationController(rootViewController: connectVC)
            naviVC.modalPresentationStyle = .fullScreen
            present(naviVC, animated: true, completion: nil)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        messageList.remove(at: indexPath.row)
        self.messageList = self.messageList.reversed()
        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: messageList, requiringSecureCoding: false)
        UserDefaults.standard.set(safedata, forKey: "\(self.uid)message")
        UserDefaults.standard.synchronize()
        self.messageList = self.messageList.reversed()
        self.messageView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
}
