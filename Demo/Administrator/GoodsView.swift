//
//  GoodsView.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class GoodsView: UIView {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        getData()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var goodsList = [GoodsInfo](){
        didSet {
            self.goodsView.reloadData()
            self.goodsView.layoutIfNeeded()
        }
    }
    var refresh : UIRefreshControl!
    var goodsView : UITableView!
    
    func setUI() {
        goodsView = UITableView.init()
        goodsView.delegate = self
        goodsView.dataSource = self
        goodsView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        self.addSubview(goodsView)
        goodsView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.goodsView.addSubview(refresh)
    }
    
    func getData() {
        AdminNetwork.shared.UncheckedGoodsRequest() { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            self.goodsList = content
            self.goodsView.reloadData()
        }
    }
    
    @objc func refreshData()  {
        goodsList.removeAll()
        getData()
        refresh.endRefreshing()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension GoodsView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let item = goodsList[indexPath.row]
        let cell = GoodsTool().TableViewCell(tableView: tableView, item: item, indexPath: indexPath,flag: 0)
        
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let VC = NextResponder().nextResponder(currentView: self)
        
        let item = goodsList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        VC.present(naviVC, animated: true, completion: nil)
        
    }
}
