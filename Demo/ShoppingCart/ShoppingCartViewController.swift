//
//  ShoppingCartViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getData()
        // Do any additional setup after loading the view.
    }
    var safedList = [GoodsInfo](){
        didSet {
            self.goodsView.reloadData()
            self.goodsView.layoutIfNeeded()
        }
    }
    
    var goodsView : UITableView!
    var bottomView : UIView!
    var countLabel : UILabel!
    var deleteButton : UIButton!
    
    var refresh : UIRefreshControl!
    
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    
    func setUI() {
        setBottomView()
        
        goodsView = UITableView.init(frame: CGRect.zero)
        goodsView.dataSource = self
        goodsView.delegate = self
        goodsView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        self.view.addSubview(goodsView)
        goodsView.snp.makeConstraints {  (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.goodsView.addSubview(refresh)
    }
    
    func setBottomView() {
        bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview()
            make.height.equalTo(75)
        }
        
        countLabel = UILabel.init()
        countLabel.text = "共\(safedList.count)件商品"
        bottomView.addSubview(countLabel)
        countLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(6)
        }
        
        deleteButton = UIButton.init()
        deleteButton.setTitle("一键清除", for: .normal)
        deleteButton.backgroundColor = UIColor.systemRed
        deleteButton.layer.masksToBounds = true
        deleteButton.layer.cornerRadius = 12
        deleteButton.addTarget(self,action:#selector(self.deleteAll(sender:)), for: .touchUpInside)
        bottomView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(2)
            make.width.equalTo(100)
        }
        
    }
    
    func getData() {
        let data = UserDefaults.standard.data(forKey: "\(uid! as Int)shoppingCart")
//        data = nil
        if data != nil {
            safedList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [GoodsInfo]
        }
        countLabel.text = "共\(safedList.count)件商品"
    }
    
    @objc func deleteAll (sender:UIButton) {
        for i in 0..<safedList.count {
            UserDefaults.standard.removeObject(forKey: "\(uid! as Int)+\(safedList[i].gid)")
        }
        safedList.removeAll()
        countLabel.text = "共\(safedList.count)件商品"
        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: safedList, requiringSecureCoding: false)
        UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)shoppingCart")
        UserDefaults.standard.synchronize()
    }
    
    @objc func refreshData()  {
        safedList.removeAll()
        getData()
        countLabel.text = "共\(safedList.count)件商品"
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

extension ShoppingCartViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
        return safedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = safedList[indexPath.row]
        let cell = GoodsTool().TableViewCell(tableView: tableView, item: item, indexPath: indexPath,flag: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = safedList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
        
    }

    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let newRowIndex = safedList.count

        UserDefaults.standard.removeObject(forKey: "\(safedList[indexPath.row].gid)")
        safedList.remove(at: indexPath.row)
        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: safedList, requiringSecureCoding: false)
        UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)shoppingCart")
        UserDefaults.standard.synchronize()
        self.goodsView.reloadData()
//        let indexpath = IndexPath(row: newRowIndex,section: 0)
//        print(indexPath.row)
//        let indexPaths = [indexPath]
//        goodsView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    
}
