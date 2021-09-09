//
//  MessageInfo.swift
//  Demo
//
//  Created by HK on 2021/5/6.
//

import UIKit

class MessageInfo: NSObject, NSCoding{
    var data :String = ""
    var source : String = ""
    var time : String = ""
    
    var gid : Int = 0
    var status : Int = 0
    var reportId : Int = 0
    
    
    required init?(coder aDecoder: NSCoder) {

        self.data = aDecoder.decodeObject(forKey: "data") as! String
        self.source = aDecoder.decodeObject(forKey: "source") as! String
        self.time = aDecoder.decodeObject(forKey: "time") as! String

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(data, forKey: "data")
        aCoder.encode(source, forKey: "source")
        aCoder.encode(time, forKey: "time")
    }
    override init() {

    }
}
