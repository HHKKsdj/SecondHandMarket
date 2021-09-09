//
//  NextResponder.swift
//  Demo
//
//  Created by HK on 2021/5/6.
//

import UIKit

class NextResponder: NSObject {
    func nextResponder(currentView:UIView)->UIViewController{
            var vc:UIResponder = currentView
            while vc.isKind(of: UIViewController.self) != true {
                vc = vc.next!
            }
            return vc as! UIViewController
     }
}
