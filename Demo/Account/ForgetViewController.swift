//
//  ForgetViewController.swift
//  Demo
//
//  Created by HK on 2021/4/28.
//

import UIKit

class ForgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        setUI()
    }
    var navigationBar : UINavigationBar!
    
    var usernameLabel : UILabel!
    var codeLabel : UILabel!
    var usernameText : UITextField!
    var codeText : UITextField!
    var newPasswordLabel : UILabel!
    var newPasswordText : UITextField!
    var getCodeButton : UIButton!
    var confirmButton : UIButton!

    func setUI() {
        navigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: 390, height: 55))
        navigationBar.backgroundColor = UIColor.white
        let navigationItem = UINavigationItem()
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.setLeftBarButton(leftItem, animated: true)
        navigationItem.title = "忘记密码"
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)
        
        usernameLabel = UILabel.init(frame: CGRect(x: 80, y: 150, width: 60, height: 35))
        usernameLabel.text = "用户名"
        self.view.addSubview(usernameLabel)
        
        usernameText = UITextField.init(frame: CGRect(x: 75, y: 200, width: 225, height: 35))
        usernameText.placeholder = "请输入用户名"
        usernameText.borderStyle = UITextField.BorderStyle.roundedRect
        usernameText.layer.masksToBounds = true
        usernameText.layer.cornerRadius = 12.0
        usernameText.layer.borderWidth = 0.5
        usernameText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(usernameText)
        usernameText.delegate = self
        
        newPasswordLabel = UILabel.init(frame: CGRect(x: 80, y: 250, width: 60, height: 35))
        newPasswordLabel.text = "新密码"
        self.view.addSubview(newPasswordLabel)
        
        newPasswordText = UITextField.init(frame: CGRect(x: 75, y: 300, width: 225, height: 35))
        newPasswordText.placeholder = "请输入新密码"
        newPasswordText.borderStyle = UITextField.BorderStyle.roundedRect
        newPasswordText.layer.masksToBounds = true
        newPasswordText.layer.cornerRadius = 12.0
        newPasswordText.layer.borderWidth = 0.5
        newPasswordText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(newPasswordText)
        newPasswordText.delegate = self
        
        
        codeLabel = UILabel.init(frame: CGRect(x: 80, y: 350, width: 150, height: 35))
        codeLabel.text = "绑定邮箱验证码"
        self.view.addSubview(codeLabel)
        
        codeText = UITextField.init(frame: CGRect(x: 75, y: 400, width: 225, height: 35))
        codeText.placeholder = "请输入验证码"
        codeText.borderStyle = UITextField.BorderStyle.roundedRect
        codeText.layer.masksToBounds = true
        codeText.layer.cornerRadius = 12.0
        codeText.layer.borderWidth = 0.5
        codeText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(codeText)
        codeText.delegate = self
        
        getCodeButton = UIButton.init(frame: CGRect.zero)
        getCodeButton.setTitle("获取验证码", for: .normal)
        getCodeButton.addTarget(self,action:#selector(self.getCode(sender:)), for: .touchUpInside)
        getCodeButton.layer.backgroundColor = UIColor.white.cgColor
        getCodeButton.setTitleColor(UIColor.systemGreen, for: .normal)
        getCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints{ (make) in
            make.top.equalTo(codeText.snp.top)
            make.left.equalTo(codeText.snp.right).offset(3)
        }

        confirmButton = UIButton.init(frame: CGRect(x: 90, y: 500, width: 200, height: 35))
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.addTarget(self,action:#selector(self.confirm(sender:)), for: .touchUpInside)
        confirmButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 12.0
        self.view.addSubview(confirmButton)
        
    }
    
    @objc func back (sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func getCode (sender:UIButton){

        AccountNetwork.shared.ForgetCodeRequest(username: usernameText.text!) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            print(content.code)
            
            var title : String!
            title = content.msg
            
            let alter = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                
            })
            alter.addAction(action)
            self.present(alter, animated: true, completion: nil)
        }
    }
    
    @objc func confirm (sender:UIButton){
    if (codeText.text!.count > 0) && (usernameText.text!.count > 0) && (newPasswordText.text!.count > 0) {
            AccountNetwork.shared.ResetPwByMailRequest(mailCode: codeText.text!,username:usernameText.text!,newPassword: newPasswordText.text!) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                print(content.code)
                
                var title : String!
                if content.code == 200 {
                    title = "修改成功,返回登录"
                } else if content.code == 400 {
                    title = "验证码错误"
                } else {
                    title = "修改失败"
                }
                
                let alter = UIAlertController(title: title, message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    if content.code == 200 {
                        self.present(LoginViewController(), animated: true, completion: nil)
                    } else {
                        self.codeText.text = ""
                    }
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

extension ForgetViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        usernameText.resignFirstResponder()
        usernameText.returnKeyType = .done
        newPasswordText.resignFirstResponder()
        newPasswordText.returnKeyType = .done
        codeText.resignFirstResponder()
        codeText.returnKeyType = .done
        return true
    }
}
