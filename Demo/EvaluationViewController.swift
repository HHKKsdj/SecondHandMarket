//
//  EvaluationViewController.swift
//  Demo
//
//  Created by HK on 2021/5/13.
//

import UIKit

class EvaluationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(send(sender:)))
        self.navigationItem.title = "评价"
        // Do any additional setup after loading the view.
        setUI()
    }
    
    var oid : Int!
    var commentLabel : UILabel!
    var typePicker : UIPickerView!
    var commentText : UITextView!
    var typeList = ["好评","中评","差评"]
    
    
    func setUI() {
        commentLabel = UILabel.init()
        commentLabel.text = "商品评价："
        self.view.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
        }
        
        typePicker = UIPickerView.init()
        typePicker.delegate = self
        typePicker.dataSource = self
        self.view.addSubview(typePicker)
        typePicker.snp.makeConstraints { (make) in
            make.top.equalTo(commentLabel.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        commentText = UITextView.init()
        commentText.isEditable = true
        commentText.text = "感觉怎么样？留下你的评论～"
        commentText.font = UIFont.systemFont(ofSize: 17.5)
        commentText.textColor = UIColor.gray
        commentText.layer.masksToBounds = true
        commentText.layer.borderColor = UIColor.black.cgColor
        commentText.layer.borderWidth = 0.5
        commentText.layer.cornerRadius = 12
        commentText.delegate = self

        self.view.addSubview(commentText)
        commentText.snp.makeConstraints { (make) in
            make.top.equalTo(typePicker.snp.bottom).offset(10)
            make.left.equalTo(commentLabel.snp.left)
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
    }
    
    @objc func send (sender:UIButton) {
        let typeRow = typePicker.selectedRow(inComponent: 0)
        let typeText = typeList[typeRow]
        if commentText.text.count > 0 {
            OrderNetwork.shared.CommentRequest(oid: oid, type: typeText, comment: commentText.text!){(error,info) in
                if let error = error {
                    print(error)
                    return
                }
                guard let content = info else {
                    print("nil")
                    return
                }
                let title : String!
                var action = UIAlertAction.init()
                if content.code == 200 {
                    title = content.msg
                    action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })
                } else {
                    title = content.msg
                    action = UIAlertAction(title: "确定", style: .default, handler: {_ in
                    })
                }
                let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
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

extension EvaluationViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
        return typeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 17.5)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = typeList[row]
        pickerLabel?.textColor = UIColor.systemBlue
        return pickerLabel!
    }
}

extension EvaluationViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        commentText.resignFirstResponder()
        commentText.returnKeyType = .done
        return true
    }
}

extension EvaluationViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "感觉怎么样？留下你的评论～"
            textView.textColor = UIColor.gray
        }
    }
}
