//
//  SortVIewController.swift
//  Demo
//
//  Created by HK on 2021/5/7.
//

import UIKit

class SortViewController: UIViewController , DataDelete{
    
    func loadData(list: String) {
        self.navigationItem.title = list
        self.sort = list
        getData()
        print(list)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: #selector(refreshData))
        navigationItem.title = sort
        // Do any additional setup after loading the view.
        getData()
        setUI()
        
    }
    
    var sort : String!
    var goodsView : UICollectionView!
    var headerView : UIView!
    var refresh : UIRefreshControl!
    
    var goodsList = [GoodsInfo]() {
        didSet{
            self.goodsView.reloadData()
        }
    }
//    var list = [[GoodsInfo]]()
    
    var list0 = [GoodsInfo]()
    var list1 = [GoodsInfo]()
    var list2 = [GoodsInfo]()
    var list3 = [GoodsInfo]()
    var list4 = [GoodsInfo]()
    var list5 = [GoodsInfo]()
    var list6 = [GoodsInfo]()
    var list7 = [GoodsInfo]()
    var list8 = [GoodsInfo]()
    var list9 = [GoodsInfo]()
    
    var page = 1
    var totalPage = 1
    
    
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 370, height: 200)
        goodsView = GoodsTool().collectionview(layout: layout)
        goodsView.delegate = self
        goodsView.dataSource = self

        self.view.addSubview(goodsView)
        goodsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.goodsView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        
//        refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        self.goodsView.addSubview(refresh)
        
    }
    
    func getData() {
        self.list0.removeAll()
        self.list1.removeAll()
        self.list2.removeAll()
        self.list3.removeAll()
        self.list4.removeAll()
        self.list5.removeAll()
        self.list6.removeAll()
        self.list7.removeAll()
        self.list8.removeAll()
        self.list9.removeAll()
        for i in 1...totalPage {
            GoodsNetwork.shared.GoodsListRequest(pageNum: i) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                if self.totalPage != content[0].pages {
                    self.totalPage = content[0].pages
                }
                for good in content {
                    switch good.label {
                    case "书籍":
                        self.list0.append(good)
                    case "鞋包":
                        self.list1.append(good)
                    case "电器":
                        self.list2.append(good)
                    case "电脑配件":
                        self.list3.append(good)
                    case "家纺":
                        self.list4.append(good)
                    case "生活百货":
                        self.list5.append(good)
                    case "运动用品":
                        self.list6.append(good)
                    case "手机配件":
                        self.list7.append(good)
                    case "交通工具":
                        self.list8.append(good)
                    case "其他":
                        self.list9.append(good)
                    default:
                        self.list9.append(good)
                    }
                }
                if i == self.totalPage {
                    switch self.sort {
                    case "书籍":
                        self.goodsList = self.list0
                    case "鞋包":
                        self.goodsList = self.list1
                    case "电器":
                        self.goodsList = self.list2
                    case "电脑配件":
                        self.goodsList = self.list3
                    case "家纺":
                        self.goodsList = self.list4
                    case "生活百货":
                        self.goodsList = self.list5
                    case "运动用品":
                        self.goodsList = self.list6
                    case "手机配件":
                        self.goodsList = self.list7
                    case "交通工具":
                        self.goodsList = self.list8
                    case "其他":
                        self.goodsList = self.list9
                    default:
                        self.goodsList = self.list9
                    }
                    if i == self.totalPage {
                        self.goodsView.reloadData()
                    }
//                    self.goodsView.reloadData()
                }
                
            }
        }
        
        
    }
    @objc func refreshData()  {
        getData()
        refresh.endRefreshing()
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

extension SortViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 15
        return goodsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GoodsTool().viewCell(collectionView: collectionView, item: goodsList[indexPath.row], indexPath: indexPath)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        headerView.dataDelete = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = goodsList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
    }
    
}
