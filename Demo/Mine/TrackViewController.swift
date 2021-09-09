//
//  TrackViewController.swift
//  Demo
//
//  Created by HK on 2021/5/11.
//

import UIKit

class TrackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "一键清除", style: .plain, target: self, action: #selector(deleteAll(sender:)))
        self.navigationItem.title = "浏览历史"
        // Do any additional setup after loading the view.
        getData()
        setUI()
    }
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    var trackList = [GoodsInfo]()
    
    var tableView : UITableView!
    
    
    func setUI() {
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func getData() {
        let data = UserDefaults.standard.data(forKey: "\(uid! as Int)track")
//        data = nil
        if data != nil {
            trackList = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [GoodsInfo]
        }
        trackList = trackList.reversed()
    }
    
    @objc func deleteAll (sender:UIButton) {
        trackList.removeAll()
        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: trackList, requiringSecureCoding: false)
        UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)track")
        UserDefaults.standard.synchronize()
        tableView.reloadData()
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

extension TrackViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = trackList[indexPath.row]
        let cell = GoodsTool().TableViewCell(tableView: tableView, item: item, indexPath: indexPath, flag: 1)
        
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = trackList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        trackList.remove(at: indexPath.row)
        trackList = trackList.reversed()
        let safedata = try? NSKeyedArchiver.archivedData(withRootObject: trackList , requiringSecureCoding: false)
        UserDefaults.standard.set(safedata, forKey: "\(uid! as Int)track")
        UserDefaults.standard.synchronize()
        trackList = trackList.reversed()
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
}
