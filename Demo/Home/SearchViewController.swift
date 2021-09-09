//
//  SearchViewController.swift
//  Demo
//
//  Created by HK on 2021/4/17.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "搜索"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        setUI()
    }

    var searchText : UITextField!
    var searchButton : UIButton!
    
    var searchBar : UISearchBar!
    
    
    func setUI() {

        searchBar = UISearchBar.init(frame: CGRect(x: 15, y: 120, width: 300, height: 35))
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 15
        searchBar.placeholder = "请输入关键词（两字以上）"
//        searchBar.layer.borderWidth
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        
        searchButton = UIButton.init(frame: CGRect.zero)
        searchButton.setTitle(" 搜索 ", for: .normal)
        searchButton.addTarget(self,action:#selector(self.search(sender:)), for: .touchUpInside)
        searchButton.layer.backgroundColor = UIColor.orange.cgColor
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 12.0
        self.view.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
//            make.left.equalTo(searchText.snp.right).offset(15)
//            make.top.equalTo(searchText)
//            make.bottom.equalTo(searchText)
            make.left.equalTo(searchBar.snp.right).offset(10)
            make.top.equalTo(searchBar)
            make.bottom.equalTo(searchBar)
        }
    }

    @objc func back(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func search (sender:UIButton) {
        let keyValue = searchBar.text
//        var list = [GoodsInfo]()
        
        GoodsNetwork.shared.SearchGoodsRequest(keyValue: keyValue!) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let list = info else {
                print("nil")
                return
            }
            
            let goodsListVC = GoodsListViewController()
            goodsListVC.goodsList = list
            let naviVC = UINavigationController(rootViewController: goodsListVC)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true, completion: nil)
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

extension SearchViewController :UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        searchBar.resignFirstResponder()
        searchBar.returnKeyType = .done

        return true
    }
}
