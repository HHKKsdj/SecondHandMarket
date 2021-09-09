//
//  AddViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit
import AnyImageKit

class AddViewController: UIViewController,ImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(back(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(send(sender:)))
        navigationItem.title = "发布"
        setUI()
    }
    
    let sortList = ["书籍","鞋包","电器","电脑配件","家纺","生活百货","运动用品","手机配件","交通工具","其他"]
    var sortPicker : UIPickerView!
    
    
    var titleLabel : UILabel!
    var titleText : UITextField!
    var descriptionLabel : UILabel!
    var descriptionText : UITextView!
    var qualityLabel : UILabel!
    var qualityText : UITextField!
    var priceLabel : UILabel!
    var priceText : UITextField!
    var priceSign : UILabel!
    var imageLabel : UILabel!
    var contactLabel : UILabel!
    var contactText : UITextField!
    
    var plusImageView : UIImageView!
    var addImage : UIButton!
    var imagePicker : UIImagePickerController!
    
    var imageList = [UIImage]()
    
    
    func setUI() {
        titleLabel = UILabel.init()
        titleLabel.text = "商品分类："
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
        }
        
//        titleText = UITextField.init()
//        titleText.placeholder = "给商品写一个简洁的标题"
//        self.view.addSubview(titleText)
//        titleText.snp.makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp.top)
//            make.left.equalTo(titleLabel.snp.right).offset(10)
//        }
        
        sortPicker = UIPickerView.init()
        sortPicker.dataSource = self
        sortPicker.delegate = self
        self.view.addSubview(sortPicker)
        sortPicker.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(95)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(75)
        }
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "商品描述："
        self.view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        descriptionText = UITextView.init()
        descriptionText.isEditable = true
        descriptionText.text = "说说你的使用感受，入手渠道，转手原因..."
        descriptionText.font = UIFont.systemFont(ofSize: 17.5)
        descriptionText.textColor = UIColor.gray
        descriptionText.delegate = self
//        descriptionText.placeholder = "说说你的使用感受，入手渠道，转手原因..."
//        descriptionText
        self.view.addSubview(descriptionText)
        descriptionText.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(75)
        }
        
        qualityLabel = UILabel.init()
        qualityLabel.text = "商品成色："
        self.view.addSubview(qualityLabel)
        qualityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionText.snp.bottom).offset(25)
            make.left.equalTo(descriptionText.snp.left)
        }
        
        qualityText = UITextField.init()
        qualityText.placeholder = "商品的新旧程度，使用次数..."
        self.view.addSubview(qualityText)
        qualityText.snp.makeConstraints { (make) in
            make.top.equalTo(qualityLabel.snp.top)
            make.left.equalTo(qualityLabel.snp.right).offset(10)
        }
        qualityText.delegate = self
        
        priceLabel = UILabel.init()
        priceLabel.text = "商品价格："
        self.view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(qualityLabel.snp.bottom).offset(25)
            make.left.equalTo(qualityLabel.snp.left)
        }
        
        priceSign = UILabel.init()
        priceSign.text = "¥"
        priceSign.textColor = UIColor.red
        self.view.addSubview(priceSign)
        priceSign.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.top)
            make.left.equalTo(priceLabel.snp.right).offset(10)
        }
        
        priceText = UITextField.init()
        priceText.placeholder = "不超过99999元"
        self.view.addSubview(priceText)
        priceText.snp.makeConstraints { (make) in
            make.top.equalTo(priceSign.snp.top)
            make.left.equalTo(priceSign.snp.right).offset(5)
        }
        priceText.delegate = self
        
        contactLabel = UILabel.init()
        contactLabel.text = "联系方式："
        self.view.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(25)
            make.left.equalTo(priceLabel.snp.left)
        }
        
        contactText = UITextField.init()
        contactText.placeholder = "留下你的联系方式"
        self.view.addSubview(contactText)
        contactText.snp.makeConstraints { (make) in
            make.top.equalTo(contactLabel.snp.top)
            make.left.equalTo(contactLabel.snp.right).offset(10)
        }
        contactText.delegate = self
        
        imageLabel = UILabel.init()
        imageLabel.text = "商品图片："
        self.view.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactLabel.snp.bottom).offset(25)
            make.left.equalTo(contactLabel.snp.left)
        }
        
        addImage = UIButton.init()
        addImage.setTitle("添加图片", for: .normal)
//        addImage.backgroundColor = UIColor.orange
        addImage.setTitleColor(UIColor.orange, for: .normal)
        addImage.addTarget(self, action: #selector(addImage(sender:)), for: .touchUpInside)
        addImage.layer.masksToBounds = true
        addImage.layer.cornerRadius = 12
        self.view.addSubview(addImage)
        addImage.snp.makeConstraints { (make) in
            make.top.equalTo(imageLabel.snp.top)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(75)
        }
        
        plusImageView = UIImageView.init()
        plusImageView.image = UIImage(named: "Plus")
        
//        plusImageView.layer.masksToBounds = true
//        plusImageView.layer.borderWidth = 0.5
//        plusImageView.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(plusImageView)
        plusImageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageLabel.snp.bottom).offset(15)
            make.left.equalTo(imageLabel.snp.left)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        
    }
    
    func setImages() {
        
        var lastImageView : UIImageView!
        lastImageView = UIImageView.init()
        for i in 0..<imageList.count {
            let goodImageView : UIImageView!
            goodImageView = UIImageView.init()
            goodImageView.image = imageList[i]
            goodImageView.layer.masksToBounds = true
            goodImageView.layer.borderWidth = 0.5
            goodImageView.layer.borderColor = UIColor.gray.cgColor
            self.view.addSubview(goodImageView)
            if i == 0 {
                goodImageView.snp.makeConstraints { (make) in
                    make.top.equalTo(imageLabel.snp.bottom).offset(15)
                    make.left.equalTo(imageLabel.snp.left)
                    make.width.equalTo(75)
                    make.height.equalTo(75)
                }
            } else {
                goodImageView.snp.makeConstraints { (make) in
                    make.left.equalTo(lastImageView.snp.right).offset(5)
                    make.top.equalTo(lastImageView.snp.top)
                    make.width.equalTo(75)
                    make.height.equalTo(75)
                }
            }
            lastImageView = goodImageView
        }
    }
    
    
    func imagePickerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: ImagePickerController, didFinishPicking result: PickerResult) {
        let images = result.assets.map { $0.image }
        imageList = images
        setImages()
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func addImage(sender:UIButton) {
        let options = PickerOptionsInfo()
        let controller = ImagePickerController(options: options, delegate: self)
        present(controller, animated: true, completion: nil)
    }
    
    @objc func send(sender:UIButton) {
        let sortRow = sortPicker.selectedRow(inComponent: 0)
        let sort = sortList[sortRow]
        if descriptionText.text != nil &&  qualityText.text != nil && priceText.text != nil && contactText.text != nil {
            GoodsNetwork.shared.NewGoodsRequest(description: descriptionText.text!, label: sort, brand: "", quality: qualityText.text!, price: priceText.text!, contact: contactText.text!) { (error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                if content.code == 200 {
                    self.uploadImage(gid: content.gid)
                } else {
                    let alter = UIAlertController(title: "发布失败", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    })
                    alter.addAction(action)
                    self.present(alter, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func uploadImage(gid:Int) {
        GoodsNetwork.shared.UploadImageRequest(gid:gid,images:imageList) { (error,info) in
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
                alterTitle = "发布成功"
            } else {
                alterTitle = "发布失败"
            }
            let alter = UIAlertController(title: alterTitle, message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                if content.code == 200 {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            alter.addAction(action)
            self.present(alter, animated: true, completion: nil)
        }
    }
    
    @objc func back(sender:UIButton) {
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

extension AddViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
        self.titleText.textColor = UIColor.systemBlue
        return sortList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 17.5)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = sortList[row]
        pickerLabel?.textColor = UIColor.systemBlue
        return pickerLabel!
    }
}

extension AddViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        descriptionText.resignFirstResponder()
        descriptionText.returnKeyType = .done
        qualityText.resignFirstResponder()
        qualityText.returnKeyType = .done
        priceText.resignFirstResponder()
        priceText.returnKeyType = .done
        contactText.resignFirstResponder()
        contactText.returnKeyType = .done
        return true
    }
}

extension AddViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "说说你的使用感受，入手渠道，转手原因..."
            textView.textColor = UIColor.gray
        }
    }
}
