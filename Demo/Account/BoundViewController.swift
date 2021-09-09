//
//  EmailViewController.swift
//  Demo
//
//  Created by HK on 2021/4/28.
//

import UIKit

class BoundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.view.backgroundColor = UIColor.white
        setUI()
        // Do any additional setup after loading the view.
    }
    
    var username : String!
    var password : String!
    var idLabel : UILabel!
    var idText : UITextField!
    var keyLabel : UILabel!
    var keyText : UITextField!
    
    var emailLabel : UILabel!
    var codeLabel : UILabel!
    var emailText : UITextField!
    var codeText : UITextField!
    var getCodeButton : UIButton!
    var confirmButton : UIButton!
    var navigationBar : UINavigationBar!
    
    func setUI() {
        
        print(username as String)
        print(password as String)
        
        navigationBar = UINavigationBar.init(frame: CGRect.zero)
        navigationBar.backgroundColor = UIColor.white
        let navigationItem = UINavigationItem()
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.setLeftBarButton(leftItem, animated: true)
        navigationItem.title = "身份验证"
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        idLabel = UILabel.init(frame: CGRect(x: 80, y: 75, width: 150, height: 35))
        idLabel.text = "教务处账号"
        self.view.addSubview(idLabel)
        
        idText = UITextField.init(frame: CGRect(x: 75, y: 125, width: 225, height: 35))
        idText.placeholder = "请输入教务处账号"
        idText.borderStyle = UITextField.BorderStyle.roundedRect
        idText.layer.masksToBounds = true
        idText.layer.cornerRadius = 12.0
        idText.layer.borderWidth = 0.5
        idText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(idText)
        idText.delegate = self
        
        keyLabel = UILabel.init(frame: CGRect(x: 80, y: 175, width: 150, height: 35))
        keyLabel.text = "教务处密码"
        self.view.addSubview(keyLabel)
        
        keyText = UITextField.init(frame: CGRect(x: 75, y: 225, width: 225, height: 35))
        keyText.placeholder = "请输入教务处密码"
        keyText.borderStyle = UITextField.BorderStyle.roundedRect
        keyText.layer.masksToBounds = true
        keyText.layer.cornerRadius = 12.0
        keyText.layer.borderWidth = 0.5
        keyText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(keyText)
        keyText.delegate = self
        
        emailLabel = UILabel.init(frame: CGRect(x: 80, y: 275, width: 60, height: 35))
        emailLabel.text = "邮箱"
        self.view.addSubview(emailLabel)
        
        emailText = UITextField.init(frame: CGRect(x: 75, y: 325, width: 225, height: 35))
        emailText.placeholder = "请输入邮箱"
        emailText.borderStyle = UITextField.BorderStyle.roundedRect
        emailText.layer.masksToBounds = true
        emailText.layer.cornerRadius = 12.0
        emailText.layer.borderWidth = 0.5
        emailText.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(emailText)
        emailText.delegate = self
        
        codeLabel = UILabel.init(frame: CGRect(x: 80, y: 375, width: 60, height: 35))
        codeLabel.text = "验证码"
        self.view.addSubview(codeLabel)
        
        codeText = UITextField.init(frame: CGRect(x: 75, y: 425, width: 225, height: 35))
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

        confirmButton = UIButton.init(frame: CGRect(x: 90, y: 550, width: 200, height: 35))
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.addTarget(self,action:#selector(self.confirm(sender:)), for: .touchUpInside)
        confirmButton.layer.backgroundColor = UIColor.systemGreen.cgColor
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 12.0
        self.view.addSubview(confirmButton)
        
    }

    @objc func getCode (sender:UIButton){
        let token = UserDefaults.standard.string(forKey: "token") as String?
        if emailText.text!.count > 0 {
            AccountNetwork.shared.GetCodeRequest(token: token!,mail: emailText.text!) { (error,info) in
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
    
    @objc func confirm (sender:UIButton){

        if codeText.text!.count > 0 && idText.text!.count > 0 && keyText.text!.count > 0 {
            
            AccountNetwork.shared.ConfirmFzuRequest(No: idText.text!, Password: keyText.text!) { (error,info) in
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
                    
                    self.confirmCode()
//                    self.logout()
//                    let loginVC = LoginViewController()
//                    loginVC.modalPresentationStyle = .fullScreen
//                    self.present(loginVC, animated: true, completion: nil)
                    
                } else {
                    let alter = UIAlertController(title: "身份认证失败", message: content.msg, preferredStyle: .alert)
                    let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    })
                    alter.addAction(action)
                    self.present(alter, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func confirmCode() {
        let token = UserDefaults.standard.string(forKey: "token") as String?
        AccountNetwork.shared.ConfirmCodeRequest(token: token!,mailCode: self.codeText.text!) { (error,info) in
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
                title = "绑定成功,请重新登录"
            } else if content.code == 400 {
                title = "验证码错误"
            } else {
                title = "绑定失败"
            }

            let alter = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                if content.code == 200 {
                    self.logout()
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                } else {
                    self.codeText.text = ""
                }
            })
            alter.addAction(action)
            self.present(alter, animated: true, completion: nil)
        }
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

extension BoundViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        idText.resignFirstResponder()
        idText.returnKeyType = .done
        keyText.resignFirstResponder()
        keyText.returnKeyType = .done
        emailText.resignFirstResponder()
        emailText.returnKeyType = .done
        codeText.resignFirstResponder()
        codeText.returnKeyType = .done
        return true
    }
}
