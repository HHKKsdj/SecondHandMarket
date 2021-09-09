//
//  GoodsTool.swift
//  Demo
//
//  Created by HK on 2021/5/2.
//

import UIKit

class GoodsTool {
    let uid = UserDefaults.standard.integer(forKey: "uid") as Int?
    
    func collectionview (layout:UICollectionViewFlowLayout) -> UICollectionView {
        var goodsView : UICollectionView
//        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 175, height: 235)
//        layout.headerReferenceSize = CGSize(width: 370, height: 200)
//        layout.minimumLineSpacing = 25
        goodsView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        goodsView.register(RecommendViewCell.self, forCellWithReuseIdentifier: "RecommendViewCell")

        goodsView.backgroundColor = UIColor.white
        return goodsView
    }
    
    func viewCell(collectionView:UICollectionView,item:GoodsInfo,indexPath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendViewCell", for: indexPath) as! RecommendViewCell
//        let item = goodsList[indexPath.row]
        let no = item.gid
        cell.titleLabel.text = item.descrip
        cell.priceLabel.text = "¥\(item.price)"
        cell.sectionLabel.text = "分类："+item.label
//        if uid == item.uid {
//            let statusText : String!
//            switch item.status {
//            case -1:
//                statusText = "不合格"
//            case 0:
//                statusText = "待审核"
//            default:
//                statusText = "正常"
//            }
//            cell.statusLabel.text = "商品状态：" + statusText
//            cell.statusLabel.isHidden = false
//        }
        
        
        let url = URL(string: "http://120.77.201.16:8099/goods/getFirstPic?gid=\(no)")
        cell.imageView.kf.setImage(with: url)

        return cell
    }
    
    func TableViewCell(tableView:UITableView,item:GoodsInfo,indexPath:IndexPath,flag:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell",for: indexPath) as! ProductViewCell

        if let url = URL(string: "http://120.77.201.16:8099/user/downPic?uid=\(item.uid)") {
            let placeHolder = UIImage.init(named: "Head")
            cell.headImageView.kf.setImage(with: url,placeholder: placeHolder,options: nil,progressBlock: nil,completionHandler: nil)
        }
        if let url2 = URL(string: "http://120.77.201.16:8099/goods/getFirstPic?gid=\(item.gid)") {
            cell.goodsImageView.kf.setImage(with: url2)
        }
        
        cell.usernameLabel.text = item.nickName
        cell.contactLabel.text = "联系方式：" + item.contact
        cell.markLabel.text = "信誉：" + item.sellerEva
        cell.titleLabel.text = item.descrip
        cell.priceLabel.text = "¥\(item.price)"
        if flag == 1 {
            cell.timeLabel.text = item.time
            cell.timeLabel.isHidden = false
        }
        return cell
    }
    
    func presentDetail(item:GoodsInfo) -> UINavigationController {
        let detailVC = DetailViewController()
        detailVC.item = item
        if UserDefaults.standard.string(forKey: "\(self.uid! as Int)+\(item.gid)") != nil {
            detailVC.shoppingCartTitle = "从购物车中删除"
        } else {
            detailVC.shoppingCartTitle = "加入购物车"
        }
        item.time = getTime()
        let naviVC = UINavigationController(rootViewController: detailVC)
        naviVC.modalPresentationStyle = .fullScreen
        return naviVC
    }
    func getTime() -> String {
        var time = ""
        let nowTime = NSDate()
        let nowMonth = DateFormatter()
        nowMonth.dateFormat = "MM"
        let nowDay = DateFormatter()
        nowDay.dateFormat = "dd"
        let nowHour = DateFormatter()
        nowHour.dateFormat = "HH"
        let nowMinute = DateFormatter()
        nowMinute.dateFormat = "mm"

        let strMonth = nowMonth.string(from: nowTime as Date) as String
        let strDay = nowDay.string(from: nowTime as Date) as String
        let strHour = nowHour.string(from: nowTime as Date) as String
        let strMinute = nowMinute.string(from: nowTime as Date) as String
        time = strMonth + "月" + strDay + "日 " + strHour + ":" + strMinute
        return time
    }
}
