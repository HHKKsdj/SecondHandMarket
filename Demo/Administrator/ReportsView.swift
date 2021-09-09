//
//  ReportsView.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class ReportsView: UIView {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        getData()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gid : Int!
    var reportsList = [MessageInfo]()
    var goodsList = [GoodsInfo]()
    var reportsView : UITableView!
    var refresh : UIRefreshControl!
    
    func setUI() {
        reportsView = UITableView.init()
        
        reportsView.delegate = self
        reportsView.dataSource = self
        reportsView.register(ReportsViewCell.self, forCellReuseIdentifier: "ReportsViewCell")
        self.addSubview(reportsView)
        reportsView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.reportsView.addSubview(refresh)
    }
    func getData() {
        self.reportsList.removeAll()
        self.goodsList.removeAll()
        AdminNetwork.shared.GetReportsRequest() { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            self.reportsList = content
            for report in self.reportsList {
                self.getGood(gid: report.gid)
            }
        }
    }
    func getGood(gid:Int) {
        GoodsNetwork.shared.GetAnGoodRequest(gid: "\(gid)") { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            self.goodsList.append(content)
            self.reportsView.reloadData()
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

extension ReportsView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportsView.dequeueReusableCell(withIdentifier: "ReportsViewCell",for: indexPath) as! ReportsViewCell
        let good = goodsList[indexPath.row]
        let report = reportsList[indexPath.row]
        
        if let url = URL(string: "http://120.77.201.16:8099/goods/getFirstPic?gid=\(good.gid)") {
            cell.goodImageView.kf.setImage(with: url)
        }
        
        cell.descriptionText.text = good.descrip
        cell.reasonText.text = "举报原因：" + report.data
        switch report.status {
        case 0:
            cell.statusText.text = "状态：未处理"
        default:
            cell.statusText.text = "状态：已处理"
        }
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = NextResponder().nextResponder(currentView: self)
        
        let item = goodsList[indexPath.row]
        let report = reportsList[indexPath.row]
        let solveVC = SolveReportViewController()
        solveVC.item = item
        solveVC.reason = report.data
        solveVC.reportId = report.reportId
        let naviVC = UINavigationController(rootViewController: solveVC)
        naviVC.modalPresentationStyle = .fullScreen
        VC.present(naviVC, animated: true, completion: nil)
        
    }
    
}
