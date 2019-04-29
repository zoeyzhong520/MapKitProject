//
//  UIViewController+Alloc.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    ///Push方式
    func pushWith(vcName: String, vcTitle: String? = nil, params: [String: Any]? = nil) {
        guard let destinationVC = NSClassFromString(AppName!+"."+vcName) as? UIViewController.Type  else { return }
        
        let vc = destinationVC.init()
        vc.title = vcTitle
        if params != nil {
            if let allKeys = params?.keys {
                for key in allKeys {
                    vc.setValue(params![key], forKey: key)
                }
            }
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///Present方式
    func presentWith(vcName: String, vcTitle: String? = nil, params: [String: Any]? = nil, hasNavigationBar: Bool? = true) {
        guard let destinationVC = NSClassFromString(AppName!+"."+vcName) as? UIViewController.Type else { return }
        
        let vc = destinationVC.init()
        vc.title = vcTitle
        if params != nil {
            if let allKeys = params?.keys {
                for key in allKeys {
                    vc.setValue(params![key], forKey: key)
                }
            }
        }
        present(hasNavigationBar == true ? UINavigationController(rootViewController: vc) : vc, animated: true, completion: nil)
    }
    
}
