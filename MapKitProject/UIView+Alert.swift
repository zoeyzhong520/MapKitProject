//
//  UIView+Alert.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

extension UIView {
    
    ///提示弹框
    func showAlertWith(message: String) {
        UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "关闭").show()
    }
    
}
