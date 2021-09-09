//
//  SettingViewController.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "设置"
        setUI()
    }
    
    var tableView : UITableView!
    var itemList : [String] = ["设置昵称","设置头像","修改密码","退出登录"]
    
    
    func setUI() {
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(95)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc func back(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func logout() {
        AccountNetwork.shared.LogoutRequest() { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            print(content.code)
            if content.code == 200 {
                UserDefaults.standard.set(nil, forKey: "token")
                UserDefaults.standard.set(nil, forKey: "username")
                UserDefaults.standard.set(nil, forKey: "status")
                UserDefaults.standard.set(nil, forKey: "role")
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }
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

extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as! TableViewCell
        cell.title.text = itemList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "设置昵称", message: "", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "请输入昵称"
            }
            let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
                let nickname = alert.textFields!.first!
                self.setNickname(nickname: nickname.text!)
                
            })
            let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
                
            })
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        case 1:
            let headImageVC = HeadImageViewController()
            let naviVC = UINavigationController(rootViewController: headImageVC)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true, completion: nil)
        case 2:
            let resetVC = ResetPasswordViewController()
            let naviVC = UINavigationController(rootViewController: resetVC)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true, completion: nil)
            
        case 3:
            let alter = UIAlertController(title: "确定退出吗？", message: "", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
                self.logout()
            })
            let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
                
            })
            alter.addAction(action1)
            alter.addAction(action2)
            self.present(alter, animated: true, completion: nil)
            
        default:
            print("nil")
        }
    }
    
    func setNickname(nickname:String) {
        AccountNetwork.shared.NicknameRequest(nickname: nickname) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            print(content.code)
            if content.code == 200 {
                let alter = UIAlertController(title: "设置成功", message: "", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
                })

                alter.addAction(action1)
                self.present(alter, animated: true, completion: nil)
            }
        }
    }
    
}
