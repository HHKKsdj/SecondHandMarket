//
//  CommentViewController.swift
//  Demo
//
//  Created by HK on 2021/5/13.
//

import UIKit

class CommentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "历史评价"
        // Do any additional setup after loading the view.
        getData()
        setUI()
    }
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    var page = 1
    var totalPage = 1
    
    var tableView : UITableView!
    var commentList = [CommentInfo]()
    
    
    
    func setUI() {
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommentViewCell.self, forCellReuseIdentifier: "CommentViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        
    }
    
    func getData() {
        OrderNetwork.shared.GetCommentRequest(uid: uid!, pageNum: page){(error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            self.commentList = content
            self.tableView.reloadData()
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

extension CommentViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentViewCell",for: indexPath) as! CommentViewCell
        let item = commentList[indexPath.row]
        
        if let url = URL(string: "http://120.77.201.16:8099/goods/getFirstPic?gid=\(item.gid)") {
            cell.goodsImageView.kf.setImage(with: url)
        }
        
        cell.descripText.text = item.descrip
        cell.commentText.text = item.commentType + "：" + item.comment

        return cell
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
