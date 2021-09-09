//
//  AdminNetwork.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import Alamofire
import SwiftyJSON

class AdminNetwork {
    static let shared = AdminNetwork()

    func UncheckedGoodsRequest(_ completion: @escaping (Error?, [GoodsInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/getUncheckedGoods"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]

        AF.request(url,method: .post ,headers: headers).responseJSON { responds in
            
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
                        infoList.append(info)
                    }
                    
                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func PassGoodsRequest(gid:Int,_ completion: @escaping (Error?, GoodsInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/passGoods"
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
    
    func DeleteGoodsRequest(gid:Int,reason:String,_ completion: @escaping (Error?, GoodsInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/deleteGoods"
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
    func GetReportsRequest(_ completion: @escaping (Error?, [MessageInfo]?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/getReports"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
//        let parameters : [String:Any] = ["gid":"\(gid)"]

        AF.request(url,method: .post ,headers: headers).responseJSON { responds in
            
            switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    var infoList = [MessageInfo]()
                    print(json)
                    let list = json["list"]
                    for (_,item):(String,JSON) in list {
                        let info = MessageInfo()
                        info.data = item["reason"].string!
                        info.gid = item["target"].int!
                        info.status = item["status"].int!
                        info.reportId = item["reportId"].int!
                        infoList.append(info)
                    }

                    completion(nil, infoList)
                case .failure(let error):
                    completion(error, nil)
            }
        }
    }
    
    func SolveReportsRequest(reportId:Int,result:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/solveReports"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["reportId":"\(reportId)","result":result]

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
    func PunishRequest(uid:Int,score:String,reason:String,_ completion: @escaping (Error?, AccountInfo?) -> ()) {
        let url = "http://120.77.201.16:8099/admin/punishUser"
        let token = UserDefaults.standard.string(forKey: "token")! as String
        let headers : HTTPHeaders = ["token":token]
        let parameters : [String:Any] = ["uid":"\(uid)","score":score,"reason":reason]

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
}
