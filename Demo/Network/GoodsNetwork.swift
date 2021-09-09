//
//  ProductNetwork.swift
//  Demo
//
//  Created by HK on 2021/5/1.
//

import Alamofire
import SwiftyJSON

class GoodsNetwork {
    static let shared = GoodsNetwork()
    
    func GoodsListRequest(pageNum:Int,_ completion: @escaping (Error?, [GoodsInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/getGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let parameters : [String:Any] = ["pageNum":"\(pageNum)"]
        let headers : HTTPHeaders = ["token":token]
        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [GoodsInfo]()
                    print(json)
                    
                    let list = json["list"]
                    for (_,item):(String,JSON) in list {
                        let info = GoodsInfo()
                        info.price = item["price"].float!
                        info.quality = item["quality"].string!
                        info.label = item["label"].string!
                        info.status = item["status"].int!
                        info.gid = item["gid"].int!
                        info.uid = item["uid"].int!
                        info.descrip = item["description"].string!
                        info.uploadTime = item["uploadTime"].string!
                        info.imgNum = item["imgNum"].int!
                        info.contact = item["contact"].string!
                        info.nickName = item["nickName"].string!
                        info.pages = json["pages"].int!
                        let mark = item["sellerEva"].int!
                        switch mark {
                        case 1:
                            info.sellerEva = "优秀"
                        case 2:
                            info.sellerEva = "良好"
                        case 3:
                            info.sellerEva = "一般"
                        default:
                            info.sellerEva = "较差"
                        }
                        info.pages = json["pages"].int!
                        
                        infoList.append(info)
                    }
                    
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func PersonalGoodsListRequest(uid:Int,pageNum:Int,_ completion: @escaping (Error?, [GoodsInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/getUserGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["uid":"\(uid)","pageNum":"\(pageNum)"]
        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [GoodsInfo]()
                    print(json)
                    
                    let list = json["list"]
                    for (_,item):(String,JSON) in list {
                        let info = GoodsInfo()
                        info.price = item["price"].float!
                        info.quality = item["quality"].string!
                        info.label = item["label"].string!
                        info.status = item["status"].int!
                        info.gid = item["gid"].int!
                        info.uid = item["uid"].int!
                        info.descrip = item["description"].string!
                        info.uploadTime = item["uploadTime"].string!
                        info.imgNum = item["imgNum"].int!
                        info.contact = item["contact"].string!
//                        info.nickName = item["nickName"].string!
                        info.pages = json["pages"].int!
                        infoList.append(info)
                    }
                    
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func SearchGoodsRequest(keyValue:String,_ completion: @escaping (Error?, [GoodsInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/searchGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["keyValue":keyValue]
//        print(keyValue)
        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [GoodsInfo]()
                    print(json)
                    
                    let list = json["list"]
                    for (_,item):(String,JSON) in list {
                        let info = GoodsInfo()
                        info.price = item["price"].float!
                        info.quality = item["quality"].string!
                        info.label = item["label"].string!
                        info.status = item["status"].int!
                        info.gid = item["gid"].int!
                        info.uid = item["uid"].int!
                        info.descrip = item["description"].string!
                        info.uploadTime = item["uploadTime"].string!
                        info.imgNum = item["imgNum"].int!
                        info.contact = item["contact"].string!
                        info.nickName = item["nickName"].string!
                        infoList.append(info)
                    }
                    
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func NewGoodsRequest(description:String,label:String,brand:String,quality:String,price:String,contact:String,_ completion: @escaping (Error?, GoodsInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/newGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["description":description,"label":label,"brand":brand,"quality":quality,"price":price,"contact":contact]

        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = GoodsInfo()
                    print(json)
                    info.code = json["code"].int!
                    if info.code == 200 {
                        let data = json["data"]
                        info.gid = data["gid"].int!
                    }
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func UploadImageRequest(gid:Int,images:[UIImage], _ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/upload"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":"\(gid)"]
        
        AF.upload(multipartFormData: { uploads in
            for (key, value) in parameters {
                    //参数的上传
                uploads.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)

            }
//            let resize = CGSize(width: 50, height: 75)
            
            for i in 0..<images.count {
//                let image = images[i].reSizeImage(reSize: resize)
                
                let imageData = images[i].jpegData(compressionQuality: 0.5)
                let fileName = "\(gid)/\(i).jpeg"
                    uploads.append(imageData!, withName: "uploads", fileName: fileName, mimeType: "image/jpeg")
            }
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
    
    func DeleteGoodsRequest(gid:Int,_ completion: @escaping (Error?, GoodsInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/deleteGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":"\(gid)"]

        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = GoodsInfo()
                    print(json)
                    info.code = json["code"].int!
                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func ReportGoodRequest(gid:Int,reason:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/report"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":"\(gid)","reason":reason]

        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
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
    
    func GetAnGoodRequest(gid:String,_ completion: @escaping (Error?, GoodsInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/getAnGood"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":gid]

        AF.request(url,method: .get ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = GoodsInfo()
                    print(json)
                    info.price = json["price"].float!
                    info.quality = json["quality"].string!
                    info.label = json["label"].string!
                    info.status = json["status"].int!
                    info.gid = json["gid"].int!
                    info.uid = json["uid"].int!
                    info.descrip = json["description"].string!
                    info.uploadTime = json["uploadTime"].string!
                    info.imgNum = json["imgNum"].int!
                    info.contact = json["contact"].string!

                    
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func EditGoodRequest(gid:Int,description:String,label:String,brand:String,quality:String,price:String,contact:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/editGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":gid,"description":description,"label":label,"brand":brand,"quality":quality,"price":price,"contact":contact]

        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
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
    
    func SetBuyCodeRequest(gid:Int,buyCode:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/goods/setBuyCode"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["gid":"\(gid)","buyCode":buyCode]
        AF.request(url,method: .post ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    let info = AccountInfo()
                    print(json)
                    info.code = json["code"].int!
                    info.msg = json["msg"].string!
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
}
