//
//  RegisterViewController.swift
//  Demo
//
//  Created by HK on 2021/4/8.
//

import UIKit


class RegisterViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.modalTransitionStyle = .
        self.view.backgroundColor = UIColor.white
        setUI()
        // Do any additional setup after loading the view.
    }
    var navigationBar : UINavigationBar!
    var usernameLabel : UILabel!
    var passwordLabel : UILabel!
    var usernameText : UITextField!
    var passwordText : UITextField!
    var registerButton : UIButton!
    var errorImage1 : UIImageView!
    var errorImage2 : UIImageView!

    func setUI() {
//        navigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: 390, height: 55))
        navigationBar = UINavigationBar.init(frame: CGRect.zero)
        navigationBar.backgroundColor = UIColor.white
        let navigationItem = UINavigationItem()
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.setLeftBarButton(leftItem, animated: true)
        navigationItem.title = "注册"
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        usernameLabel = UILabel.init(frame: CGRect(x: 90, y: 150, width: 60, height: 35))
        usernameLabel.text = "账号"
        self.view.addSubview(usernameLabel)
        
        usernameText = UITextField.init(frame: CGRect(x: 85, y: 200, width: 225, height: 35))
        usernameText.placeholder = "不少于1位"
        usernameText.borderStyle = UITextField.BorderStyle.roundedRect
        usernameText.layer.masksToBounds = true
        usernameText.layer.cornerRadius = 12.0
        usernameText.layer.borderWidth = 0.5
        usernameText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(usernameText)
        usernameText.delegate = self
        
        errorImage1 = UIImageView.init(frame: CGRect(x: 320, y: 200, width: 30, height: 30))
        errorImage1.image = UIImage(named: "Error")
        errorImage1.isHidden = true
        self.view.addSubview(errorImage1)
        
        passwordLabel = UILabel.init(frame: CGRect(x: 90, y: 300, width: 60, height: 35))
        passwordLabel.text = "密码"
        self.view.addSubview(passwordLabel)
        
        passwordText = UITextField.init(frame: CGRect(x: 85, y: 350, width: 225, height: 35))
        passwordText.placeholder = "不少于6位"
        passwordText.borderStyle = UITextField.BorderStyle.roundedRect
        passwordText.layer.masksToBounds = true
        passwordText.layer.cornerRadius = 12.0
        passwordText.layer.borderWidth = 0.5
        passwordText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(passwordText)
        passwordText.delegate = self
        
        errorImage2 = UIImageView.init(frame: CGRect(x: 320, y: 350, width: 30, height: 30))
        errorImage2.image = UIImage(named: "Error")
        errorImage2.isHidden = true
        self.view.addSubview(errorImage2)

        registerButton = UIButton.init(frame: CGRect(x: 90, y: 475, width: 200, height: 35))
        registerButton.setTitle("注册", for: .normal)
        registerButton.addTarget(self,action:#selector(self.register(sender:)), for: .touchUpInside)
        registerButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 12.0
        self.view.addSubview(registerButton)
        
    }
    
    @objc func back (sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func register(sender:UIButton) {

        if  usernameText.text!.count <= 1 && passwordText.text!.count <= 6 {
            self.errorImage1.isHidden = false
            self.errorImage2.isHidden = false
        } else if usernameText.text!.count <= 1 {
            self.errorImage1.isHidden = false
            self.errorImage2.isHidden = true
        } else if passwordText.text!.count < 6 {
            self.errorImage1.isHidden = true
            self.errorImage2.isHidden = false
        } else {
            self.errorImage1.isHidden = true
            self.errorImage2.isHidden = true
            AccountNetwork.shared.RegisterRequest(username: self.usernameText.text!, password: self.passwordText.text!) { (error,info) in
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
                    title = "注册成功,进行身份验证"
                } else if content.code == 500 {
                    title = "用户名已存在"
                } else {
                    title = "注册失败"
                }

                let alter = UIAlertController(title: title, message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    if content.code == 200 {

                        self.login()

                        let BoundVC = BoundViewController()
                        BoundVC.password = self.passwordText.text
                        BoundVC.username = self.usernameText.text
                        self.present(BoundVC, animated: true, completion: nil)
                    } else {
                        self.usernameText.text = ""
                        self.passwordText.text = ""
                    }
                })
                alter.addAction(action)
                self.present(alter, animated: true, completion: nil)
            }
        }
    }
    
    func login() {
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
        }
    }
    
}

extension RegisterViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        usernameText.resignFirstResponder()
        usernameText.returnKeyType = .done
        passwordText.resignFirstResponder()
        passwordText.returnKeyType = .done
        return true
    }
}
