//
//  AdministratorViewController.swift
//  Demo
//
//  Created by HK on 2021/5/3.
//

import UIKit

class AdministratorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "管理模式"
        setUI()
    }
    
    var segment : UISegmentedControl!
    var goodsView : UIView!
    var reportsView : UIView!
    
    
    func setUI()  {
        segment = UISegmentedControl.init(items: ["商品管理","举报管理"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentDidChange(sender:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(segment)
        segment.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(95)
        }
        
        goodsView = GoodsView()
        self.view.addSubview(goodsView)
        goodsView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(segment.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
        goodsView.isHidden = false
        
        reportsView = ReportsView()
        self.view.addSubview(reportsView)
        reportsView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(segment.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
        reportsView.isHidden = true
    }

    @objc func segmentDidChange(sender:UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            goodsView.isHidden = false
            reportsView.isHidden = true
        } else {
            goodsView.isHidden = true
            reportsView.isHidden = false
        }
    }
    
    @objc func back(sender:UIButton) {
        let alter = UIAlertController(title: "确定退出管理模式吗？", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "确定", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        let action2 = UIAlertAction(title: "取消", style: .default, handler: {_ in
            
        })
        alter.addAction(action1)
        alter.addAction(action2)
        self.present(alter, animated: true, completion: nil)
        
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
