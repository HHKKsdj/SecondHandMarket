//
//  OrderNetwork.swift
//  Demo
//
//  Created by HK on 2021/5/13.
//

import Alamofire
import SwiftyJSON

class OrderNetwork {
    static let shared = OrderNetwork()

    func CommentRequest(oid:Int,type:String,comment:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/order/comment"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["oid":"\(oid)","type":type,"comment":comment]
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
    
    func GetCommentRequest(uid:Int,pageNum:Int,_ completion: @escaping (Error?, [CommentInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/order/getUserReceivedComments"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["uid":"\(uid)","pageNum":pageNum]
        AF.request(url,method: .get ,parameters: parameters,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [CommentInfo]()
                    print(json)
                    let list = json["list"]
                    for (_,item):(String,JSON) in list {
                        let info = CommentInfo()
                        info.comment = item["b_Comment"].string!
                        info.commentType = item["b_Type"].string!
                        let good = item["goods"]
                        info.descrip = good["description"].string!
                        info.gid = good["gid"].int!
                        infoList.append(info)
                    }
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    func BuyRequest(gid:Int,buyCode:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/order/buy"
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
                    if info.code == 200 {
                        let data = json["data"]
                        info.oid = data["oid"].int!
                    }
                    completion(nil, info)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
}
