//
//  GoodsListViewController.swift
//  Demo
//
//  Created by HK on 2021/5/2.
//

import UIKit

class GoodsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        setUI()
    }
    
    var goodsList = [GoodsInfo]()
    var goodsView : UICollectionView!
    var emptyLabel : UILabel!
    var headerView : UIView!
    
    
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        goodsView = GoodsTool().collectionview(layout: layout)
        goodsView.delegate = self
        goodsView.dataSource = self
        self.view.addSubview(goodsView)
        goodsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        emptyLabel = UILabel.init()
        emptyLabel.text = "暂无结果"
        emptyLabel.textColor = UIColor.gray
        emptyLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(125)
            make.centerX.equalToSuperview()
        }
        if goodsList.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
    
    func setHeaderView() {
//        headerView = UIView.init(frame: CGRect(x: 10, y: 10, width: 50, height: 30))
//        headerView.backgroundColor = UIColor.red
//        navigationItem.titleView = headerView
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

extension GoodsListViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GoodsTool().viewCell(collectionView: collectionView, item: goodsList[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = goodsList[indexPath.row]
        
        let naviVC = GoodsTool().presentDetail(item: item)
        
        present(naviVC, animated: true, completion: nil)
    }
}
