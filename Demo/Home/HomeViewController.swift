//
//  HomeViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit
import Kingfisher
import ESPullToRefresh

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
        setUI()
    }
    var locationImageView : UIImageView!
    var locationLabel : UILabel!
    var searchLabel : UILabel!
    
    var headerView : UIView!
    var recommendView : UICollectionView!
    
    var page = 1
    var totalPage = 1
    
    let sectionList : [String] = ["书籍","鞋包","电器","电脑配件","家纺","生活百货","运动用具","手机配件","交通工具","其他"]
    var goodsList = [GoodsInfo](){
        didSet{
//            self.viewWillAppear(true)
            self.recommendView.reloadData()
        }
    }
    
    func setUI()  {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addView(sender:)))
        
        locationImageView = UIImageView.init(frame: CGRect(x: 15, y: 100, width: 32, height: 32))
        locationImageView.image = UIImage(named: "Location")
        self.view.addSubview(locationImageView)

//        locationLabel = UILabel.init(frame: CGRect(x: 60, y: 85, width: 150, height: 32))
        locationLabel = UILabel.init(frame: CGRect.zero)
        locationLabel.text = "福州大学"
        locationLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(locationImageView.snp.right).offset(15)
            make.top.equalTo(locationImageView)
            make.width.equalTo(150)
            make.height.equalTo(32)
        }
        
//        searchLabel = UILabel.init(frame: CGRect(x: 15, y: 115, width: 390-25, height: 32))
        searchLabel = UILabel.init(frame: CGRect.zero)
        searchLabel.text = "  🔍  搜索"
        searchLabel.layer.masksToBounds = true
        searchLabel.layer.cornerRadius = 12.0
        searchLabel.layer.borderWidth = 0.5
        searchLabel.layer.borderColor = UIColor.black.cgColor
        searchLabel.isUserInteractionEnabled = true
        let search = UITapGestureRecognizer(target: self, action: #selector(searchView))
        searchLabel.addGestureRecognizer(search)
        self.view.addSubview(searchLabel)
        searchLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
            make.height.equalTo(32)
        }

        setRecommendView()
        setHeaderView()
        self.recommendView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
//        refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        self.recommendView.addSubview(refresh)
        self.recommendView.es.addPullToRefresh {
            [unowned self] in
            self.page = 1
            self.goodsList.removeAll()
            self.getData()
            self.recommendView.es.stopPullToRefresh()

        }
        self.recommendView.es.addInfiniteScrolling {
            [unowned self] in
            if self.page + 1 <= self.totalPage {
                self.page += 1
                self.getData()
                self.recommendView.es.stopLoadingMore()
            } else {
                self.recommendView.es.noticeNoMoreData()
            }
        }
    }
    
    func setRecommendView() {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 370, height: 200)
        recommendView = GoodsTool().collectionview(layout: layout)
        recommendView.delegate = self
        recommendView.dataSource = self
        
        self.view.addSubview(recommendView)
        recommendView.snp.makeConstraints { (make) in
            make.top.equalTo(searchLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func setHeaderView() {
        headerView = HeaderView()
    }
    
    @objc func addView(sender:UIBarButtonItem) {
        let addvc = UINavigationController(rootViewController: AddViewController())
        addvc.modalPresentationStyle = .fullScreen
        present(addvc, animated: true, completion: nil)
    }
    
    @objc func searchView(sender:UITapGestureRecognizer) {
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true, completion: nil)
    }
    
    
    
    func getData() {
        GoodsNetwork.shared.GoodsListRequest(pageNum: page) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
//            self.goodsList = content
            for item in content {
                self.goodsList.append(item)
            }
            self.totalPage = content[0].pages
            self.recommendView.reloadData()
        }
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


extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
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
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as UICollectionReusableView
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = goodsList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
    }
    
}
