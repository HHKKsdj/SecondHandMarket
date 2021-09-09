//
//  ViewController.swift
//  Demo
//
//  Created by HK on 2021/4/6.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        checkLogin()
        setUI()
    }
    var welcomeLabel : UILabel!
    
    var usernameLabel : UILabel!
    var passwordLabel : UILabel!
    var usernameText : UITextField!
    var passwordText : UITextField!
    var loginButton : UIButton!
    var registerButton : UIButton!
    var forgetButton : UIButton!

    
    func setUI() {
        welcomeLabel = UILabel.init(frame: CGRect(x: 60, y: 100, width: 200, height: 50))
        welcomeLabel.text = "欢迎来到优尼"
        welcomeLabel.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(welcomeLabel)
        
        usernameLabel = UILabel.init(frame: CGRect(x: 90, y: 215, width: 60, height: 35))
        usernameLabel.text = "账号"
        self.view.addSubview(usernameLabel)

        
        usernameText = UITextField.init(frame: CGRect(x: 85, y: 250, width: 225, height: 35))
        usernameText.placeholder = "请输入账号"
        usernameText.borderStyle = UITextField.BorderStyle.roundedRect
        usernameText.layer.masksToBounds = true
        usernameText.layer.cornerRadius = 12.0
        usernameText.layer.borderWidth = 0.5
        usernameText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(usernameText)
        usernameText.delegate = self
        
        passwordLabel = UILabel.init(frame: CGRect(x: 90, y: 315, width: 60, height: 35))
        passwordLabel.text = "密码"
        self.view.addSubview(passwordLabel)
        
        
        
        passwordText = UITextField.init(frame: CGRect(x: 85, y: 350, width: 225, height: 35))
        passwordText.placeholder = "请输入密码"
        passwordText.borderStyle = UITextField.BorderStyle.roundedRect
        passwordText.layer.masksToBounds = true
        passwordText.layer.cornerRadius = 12.0
        passwordText.layer.borderWidth = 0.5
        passwordText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(passwordText)
        passwordText.delegate = self
        
        forgetButton = UIButton.init(frame: CGRect.zero)
        forgetButton.setTitle("忘记密码", for: .normal)
        forgetButton.addTarget(self,action:#selector(self.forget(sender:)), for: .touchUpInside)
        forgetButton.layer.backgroundColor = UIColor.white.cgColor
        forgetButton.setTitleColor(UIColor.systemGreen, for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(forgetButton)
        forgetButton.snp.makeConstraints{ (make) in
            make.top.equalTo(passwordText.snp.bottom).offset(5)
            make.left.equalTo(passwordText.snp.left).offset(5)
        }
        
//        registerButton = UIButton.init(frame: CGRect.zero)
        registerButton = UIButton.init()
        registerButton.setTitle("注册", for: .normal)
        registerButton.addTarget(self,action:#selector(self.signup(sender:)), for: .touchUpInside)
        registerButton.layer.backgroundColor = UIColor.white.cgColor
        registerButton.setTitleColor(UIColor.systemGreen, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(registerButton)
        registerButton.snp.makeConstraints{ (make) in
            make.top.equalTo(passwordText.snp.bottom).offset(5)
            make.right.equalTo(passwordText.snp.right).offset(-5)
        }
        
        loginButton = UIButton.init(frame: CGRect(x: 90, y: 475, width: 200, height: 35))
        loginButton.setTitle("登录", for: .normal)
        loginButton.addTarget(self,action:#selector(self.login(sender:)), for: .touchUpInside)
        loginButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 12.0
        self.view.addSubview(loginButton)
        
        
    }

    @objc func login(sender:UIButton) {
        if usernameText.text!.count > 0 && passwordText.text!.count > 0 {
            AccountNetwork.shared.LoginRequest(username: self.usernameText.text!, password: self.passwordText.text!) { (error,info) in
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
                    title = "登录成功"
                } else {
                    title = content.msg
                }

                let alter = UIAlertController(title: title, message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    if content.code == 200 {
                        self.present(TabBarViewController(), animated: true, completion: nil)
                    } else {
                        self.usernameText.text = ""
                        self.passwordText.text = ""
                    }
                })
                alter.addAction(action)
                self.present(alter, animated: true, completion: nil)
            }
        }
//        self.present(TabBarViewController(), animated: true, completion: nil)
    }
    
    
    
    @objc func signup(sender:UIButton) {
        let VC = RegisterViewController()
//        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }
    
    @objc func forget(sender:UIButton) {
        present(ForgetViewController(), animated: true, completion: nil)
    }
    
    func checkLogin() {
        if let token = UserDefaults.standard.string(forKey: "token") as String? {
            AccountNetwork.shared.CheckLoginRequest(token: token) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                print(content.code)
                if (content.code == 200) {
                    self.present(TabBarViewController(), animated: true, completion: nil)
                }
//                else {
//                    self.setUI()
//                }
            }
        }
        
    }
    
}

extension LoginViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        usernameText.resignFirstResponder()
        usernameText.returnKeyType = .done
        passwordText.resignFirstResponder()
        passwordText.returnKeyType = .done
        return true
    }
}
