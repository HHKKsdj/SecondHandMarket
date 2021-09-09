//
//  GoodsInfo.swift
//  Demo
//
//  Created by HK on 2021/5/1.
//

import UIKit

class GoodsInfo : NSObject, NSCoding {
    
    var gid : Int = 0
    var uid : Int = 0
    var status : Int = 0
    var price : Float = 0
    var descrip : String = ""
    var label : String = ""
    var quality : String = ""
    var uploadTime : String = ""
    var nickName : String = ""
    var contact : String = ""
    var imgNum : Int = 0
    var sellerEva : String = ""
    
    var code : Int = 0
    var pages: Int = 0
    var time : String = ""
    
    required init?(coder aDecoder: NSCoder) {
        self.gid = aDecoder.decodeInteger(forKey: "gid")
        self.uid = aDecoder.decodeInteger(forKey: "uid")
        self.status = aDecoder.decodeInteger(forKey: "status")
        self.price = aDecoder.decodeFloat(forKey: "price")
        self.descrip = aDecoder.decodeObject(forKey: "descrip") as! String
        self.label = aDecoder.decodeObject(forKey: "label") as! String
        self.quality = aDecoder.decodeObject(forKey: "quality") as! String
        self.uploadTime = aDecoder.decodeObject(forKey: "uploadTime") as! String
        self.nickName = aDecoder.decodeObject(forKey: "nickName") as! String
        self.contact = aDecoder.decodeObject(forKey: "contact") as! String
        self.imgNum = aDecoder.decodeInteger(forKey: "imgNum")
        self.sellerEva = aDecoder.decodeObject(forKey: "sellerEva") as! String
//        self.time = aDecoder.decodeObject(forKey: "time") as! String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(gid, forKey: "gid")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(descrip, forKey: "descrip")
        aCoder.encode(label, forKey: "label")
        aCoder.encode(quality, forKey: "quality")
        aCoder.encode(uploadTime, forKey: "uploadTime")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(contact, forKey: "contact")
        aCoder.encode(imgNum, forKey: "imgNum")
        aCoder.encode(sellerEva, forKey: "sellerEva")
//        aCoder.encode(time, forKey: "time")
    }
    override init() {

    }
}
