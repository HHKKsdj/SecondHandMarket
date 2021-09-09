//
//  HeaderView.swift
//  Demo
//
//  Created by HK on 2021/4/20.
//

import UIKit

protocol DataDelete {
    func loadData(list:String)
}

class HeaderView: UICollectionReusableView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    override init (frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataDelete : DataDelete?
    
    
    var sectionView : UICollectionView!
    
    let sortList : [String] = ["书籍","鞋包","电器","电脑配件","家纺","生活百货","运动用品","手机配件","交通工具","其他"]
    
//    var canPresent = 1
    
    
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 25
        sectionView = UICollectionView(frame: CGRect(x: 10, y: 10, width: self.frame.size.width - 20, height: 175), collectionViewLayout: layout)

        sectionView.register(HeaderViewCell.self, forCellWithReuseIdentifier: "HeaderViewCell")
        
        sectionView.delegate = self
        sectionView.dataSource = self
        sectionView.backgroundColor = UIColor.white
        self.addSubview(sectionView)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderViewCell", for: indexPath) as! HeaderViewCell
        let name = sortList[indexPath.row]
        let image = UIImage(named: "\(name)")
        cell.titleLabel.text = name
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = NextResponder().nextResponder(currentView: self)
        let item = sortList[indexPath.row]

        if VC.title == "首页" {
            let sortVC = SortViewController()
            sortVC.sort = item as String
            let naviVC = UINavigationController(rootViewController: sortVC)
            naviVC.modalPresentationStyle = .fullScreen
            VC.present(naviVC, animated: true, completion: nil)
        } else {
            VC.title = item
        }
        
        self.dataDelete?.loadData(list:item)
    }
    
//    @objc func searchView() {
//        present(SearchViewController(), animated: true, completion: nil)
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

