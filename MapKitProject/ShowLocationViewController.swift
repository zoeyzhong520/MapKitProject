//
//  ShowLocationViewController.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///展示地点详情
class ShowLocationViewController: BaseViewController {

    //地点
    @objc var location: String?
    
    lazy var showLocationView: ShowLocationView = {
        let showLocationView = ShowLocationView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ContentHeight))
        showLocationView.locationEnCode(address: self.title ?? "")
        return showLocationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    ///UI
    func setPage() {
        view.addSubview(showLocationView)
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
