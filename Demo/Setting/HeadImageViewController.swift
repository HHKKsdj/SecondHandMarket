//
//  HeadImageViewController.swift
//  Demo
//
//  Created by HK on 2021/5/8.
//

import UIKit
import AnyImageKit

class HeadImageViewController: UIViewController,ImagePickerControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.title = "设置头像"
        // Do any additional setup after loading the view.
        setUI()
    }
    
    var headImageView : UIImageView!
    var pickButton : UIButton!
    var uploadButton : UIButton!
    var imagePicker : UIImagePickerController!
    var headImage : UIImage!
    
    
    func setUI() {
        headImageView = UIImageView.init()
        headImageView.image = UIImage(named: "Plus")
        headImageView.clipsToBounds = true
        headImageView.contentMode = .scaleAspectFit
//        headImageView.layer.masksToBounds = true
//        headImageView.layer.borderWidth = 0.5
//        headImageView.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(headImageView)
        headImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        pickButton = UIButton.init()
        pickButton.setTitle("选择图片", for: .normal)
        pickButton.setTitleColor(UIColor.orange, for: .normal)
        pickButton.addTarget(self, action: #selector(pickImage(sender:)), for: .touchUpInside)
        self.view.addSubview(pickButton)
        pickButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.width.equalTo(100)
        }
        
        uploadButton = UIButton.init()
        uploadButton.setTitle("确定", for: .normal)
        uploadButton.backgroundColor = UIColor.systemGreen
        uploadButton.layer.masksToBounds = true
        uploadButton.layer.cornerRadius = 12.0
        uploadButton.addTarget(self, action: #selector(upload(sender:)), for: .touchUpInside)
        self.view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
    }
    
    @objc func pickImage (sender:UIButton) {
        let options = PickerOptionsInfo()
        let controller = ImagePickerController(options: options, delegate: self)
        present(controller, animated: true, completion: nil)
    }
    
    @objc func upload (sender:UIButton) {
        AccountNetwork.shared.UploadHeadImageRequest(image: headImage) { (error,info) in
            if let error = error {
                print(error)
                return
            }
            guard let content = info else {
                print("nil")
                return
            }
            var alterTitle : String!
            
            if content.code == 200 {
                alterTitle = "上传成功"
            } else {
                alterTitle = "上传失败"
            }
            let alter = UIAlertController(title: alterTitle, message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                
            })
            alter.addAction(action)
            self.present(alter, animated: true, completion: nil)
        }
    }
    
    @objc func back (sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult) {
        let images = result.assets.map { $0.image }
        headImage = images[0]
        headImageView.image = headImage
        picker.dismiss(animated: true, completion: nil)
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
