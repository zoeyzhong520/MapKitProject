//
//  AddLocationViewController.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol AddLocationViewControllerDelegate: NSObjectProtocol {
    @objc optional
    func didAddLocation()
}

///添加地点
class AddLocationViewController: BaseViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: StatusBarHeight+NavigationBarHeight, width: ScreenSize.width, height: 50))
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        label.text = "  请输入详细位置"
        return label
    }()
    
    lazy var inputTF: UITextField = {
        let inputTF = UITextField(frame: CGRect(x: 0, y: self.titleLabel.frame.maxY, width: self.titleLabel.frame.self.width, height: 50))
        inputTF.font = self.titleLabel.font
        inputTF.textColor = .black
        inputTF.addTarget(self, action: #selector(textEditing(_:)), for: .editingChanged)
        inputTF.delegate = self
        inputTF.returnKeyType = UIReturnKeyType.done
        inputTF.becomeFirstResponder()
        return inputTF
    }()
    
    weak var delegate: AddLocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setPage()
    }
    
    //MARK: - UI
    func setNavigation() {
        //注：在PROJECT - Localizations中可预先设置添加需要本地化的语言
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveLocation))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
    }
    
    func setPage() {
        view.addSubview(titleLabel)
        view.addSubview(inputTF)
    }
    
    @objc func back() {
        inputTF.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveLocation() {
        guard let inputStr = inputTF.text else { return }
        
        if inputStr.count == 0 || inputStr.contains(" ") {//非空判断
            showAlertWith(message: "请先输入详细位置")
            return
        }
        
        CoreDataManager.shared.saveLocationWith(location: inputTF.text!)//保存添加的地点信息
        
        if delegate != nil {
            delegate?.didAddLocation?()
        }
        
        back()
    }

    @objc func textEditing(_ inputTF: UITextField) {
        if inputTF.text?.count != 0 {
            print(inputTF.text!)
        }
    }
    
    //调用TouchsBegin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)//停止编辑
    }

}

extension AddLocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
