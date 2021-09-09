//
//  ResetPasswordViewController.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        setUI()
    }
    
    var passwordLabel : UILabel!
    var passwordText : UITextField!
    var newPasswordLabel : UILabel!
    var newPasswordText : UITextField!
    var confirmButton : UIButton!
    var errorImageView : UIImageView!
    
    
    func setUI() {
        passwordText = UITextField.init()
        passwordText.placeholder = "请输入密码"
        passwordText.borderStyle = UITextField.BorderStyle.roundedRect
        passwordText.layer.masksToBounds = true
        passwordText.layer.cornerRadius = 12.0
        passwordText.layer.borderWidth = 0.5
        passwordText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(passwordText)
        passwordText.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(200)
            make.height.equalTo(35)
        }
        
        passwordLabel = UILabel.init()
        passwordLabel.text = "密码:"
        self.view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints{ (make) in
            make.right.equalTo(passwordText.snp.left)
            make.bottom.equalTo(passwordText.snp.top).offset(-15)
        }
        
        newPasswordLabel = UILabel.init()
        newPasswordLabel.text = "新密码:"
        self.view.addSubview(newPasswordLabel)
        newPasswordLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(passwordLabel.snp.left)
            make.top.equalTo(passwordText.snp.bottom).offset(50)
        }
        
        newPasswordText = UITextField.init()
        newPasswordText.placeholder = "请输入新密码(不少于6位)"
        newPasswordText.borderStyle = UITextField.BorderStyle.roundedRect
        newPasswordText.layer.masksToBounds = true
        newPasswordText.layer.cornerRadius = 12.0
        newPasswordText.layer.borderWidth = 0.5
        newPasswordText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(newPasswordText)
        newPasswordText.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(35)
        }
        
        errorImageView = UIImageView.init()
        errorImageView.image = UIImage(named: "Error")
        self.view.addSubview(errorImageView)
        errorImageView.snp.makeConstraints{ (make) in
            make.centerY.equalTo(newPasswordText.snp.centerY)
            make.left.equalTo(newPasswordText.snp.right).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        errorImageView.isHidden = true
        
        confirmButton = UIButton.init()
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.addTarget(self,action:#selector(self.confirm(sender:)), for: .touchUpInside)
        confirmButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 12.0
        self.view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(newPasswordText.snp.bottom).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
    
    @objc func back(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirm(sender:UIButton) {
        if newPasswordText.text!.count < 6 {
            errorImageView.isHidden = false
        } else if passwordText.text!.count > 0 {
            errorImageView.isHidden = true
            AccountNetwork.shared.ResetPasswordRequest(oldPassword: passwordText.text!, newPassword: passwordText.text!) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                print(content.code)
                var alterTitle : String!
                
                if content.code == 200 {
                    alterTitle = "修改成功"
                } else if content.code == 403 {
                    alterTitle = "密码错误"
                } else {
                    alterTitle = "修改失败"
                }

                let alter = UIAlertController(title: alterTitle, message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                      
                })
                alter.addAction(action)
                self.present(alter, animated: true, completion: nil)
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
