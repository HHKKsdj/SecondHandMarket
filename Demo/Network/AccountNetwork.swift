//
//  File.swift
//  Demo
//
//  Created by HK on 2021/4/6.
//

import Alamofire
import SwiftyJSON

class AccountNetwork {
    static let shared = AccountNetwork()
    
    func LoginRequest(username:String, password:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let parameters : [String:Any] = ["username":"\(username)","password":"\(password)"]
        
        let url = "http://120.77.201.16:8099/user/login"
        AF.request(url,method: .post,parameters: parameters).responseJSON { responds in

                switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    if info.code == 200 {
                        let data = json["data"]
                        let token = data["jwtToken"].string!
                        let user = data["user"]
                        let username : String!
                        
                        if user["nickName"].string!.count > 0 {
                            username = user["nickName"].string!
                        } else {
                            username = user["username"].string!
                        }
                        
                        let status = user["status"].int!
                        let role = user["role"].string!
                        let uid = user["uid"].int!
                        
   //                    if UserDefaults.standard.string(forKey: "token") == nil {
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set(status, forKey: "status")
                        UserDefaults.standard.set(role, forKey: "role")
                        UserDefaults.standard.set(uid, forKey: "uid")
   //                    }
                    }
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func RegisterRequest(username:String, password:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let parameters : [String:Any] = ["username":"\(username)","password":"\(password)"]
        let url = "http://120.77.201.16:8099/user/Register"
        AF.request(url,method: .post,parameters: parameters).responseJSON { responds in

                switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func GetCodeRequest(token:String,mail:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/setMailAddr"
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["mailAddr":"\(mail)"]
        
        AF.request(url,method: .post,parameters: parameters,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ConfirmCodeRequest(token:String,mailCode:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/confirmAddr"
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["mailCode":"\(mailCode)"]
        
        AF.request(url,method: .post,parameters: parameters,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ForgetCodeRequest(username:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/sendMail"
        let parameters : [String:Any] = ["username":"\(username)"]
        
        AF.request(url,method: .post,parameters: parameters).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ResetPwByMailRequest(mailCode:String,username:String,newPassword:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/ResetPwByMail"
        let parameters : [String:Any] = ["mailCode":"\(mailCode)","username":"\(username)","newPassword":"\(newPassword)"]
        
        AF.request(url,method: .post,parameters: parameters).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ConfirmFzuRequest(No:String,Password:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/confirmFzu"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["No":No,"Password":Password]
        
        AF.request(url,method: .post,parameters: parameters,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func CheckLoginRequest(token:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/user/isLogin"
        let headers : HTTPHeaders = ["token":token]
//        let parameters : [String:Any] = ["_csrf":token]
        
        AF.request(url,method: .post,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func LogoutRequest(_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let url = "http://120.77.201.16:8099/user/loginOut"
        let headers : HTTPHeaders = ["token":token]
        
        AF.request(url,method: .post,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ResetPasswordRequest(oldPassword:String,newPassword:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let url = "http://120.77.201.16:8099/user/ResetPw"
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["oldPassword":oldPassword,"newPassword":newPassword]
        
        AF.request(url,method: .post,parameters: parameters,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func CheckAdminRequest(_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let url = "http://120.77.201.16:8099/user/confirmAddr"
        let headers : HTTPHeaders = ["token":token]
        
        AF.request(url,method: .post,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func GetMessagesRequest(_ completion: @escaping (Error?, [MessageInfo]?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let url = "http://120.77.201.16:8099/user/getUserMessages"
        let headers : HTTPHeaders = ["token":token]
        
        AF.request(url,method: .post,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [MessageInfo]()
                    print(json)
                    for (_,item):(String,JSON) in json {
                        let info = MessageInfo()
                        info.data = item["data"].string!
                        info.source = item["source"].string!
                        info.time = item["time"].string!
                        infoList.append(info)
                    }
                    
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func NicknameRequest(nickname:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let url = "http://120.77.201.16:8099/user/editNickName"
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["nickName":nickname]
        
        AF.request(url,method: .post,parameters: parameters,headers: headers).responseJSON { responds in

            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func UploadHeadImageRequest(image:UIImage,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let uid = UserDefaults.standard.integer(forKey: "uid") as Int
        
        let url = "http://120.77.201.16:8099/user/upload"
        let headers : HTTPHeaders = ["token":token]
        
        AF.upload(multipartFormData: { uploads in
            
            let imageData = image.jpegData(compressionQuality: 0.5)
            let fileName = "\(uid).jpeg"
            uploads.append(imageData!, withName: "upload", fileName: fileName, mimeType: "image/jpeg")
            
        },to: url,method: .post, headers: headers)
            .responseJSON { response in
                switch response.result {
                
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    info.status = json["status"].bool!
                    
                    print(json)
                    completion(nil, info)
                case .failure(let error):
                    print("nil")
                    completion(error, nil)
                }
        }
    }
    
}
