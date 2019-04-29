//
//  LocationViewController.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///地点列表展示
class LocationViewController: BaseViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ContentHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: BaseTableReuseIdentifier)
        return tableView
    }()
    
    lazy var dataSource: [LocationEntity] = {
        let dataSource = CoreDataManager.shared.getAllLocation()//获取全部地点
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setPage()
    }
    
    //MARK: - UI
    func setNavigation() {
        title = "地点"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
    }
    
    func setPage() {
        view.addSubview(tableView)
    }
    
    @objc func addLocation() {
        //模态视图
        let addLocationVC = AddLocationViewController()
        addLocationVC.delegate = self
        present(UINavigationController(rootViewController: addLocationVC), animated: true, completion: nil)
    }

}

extension LocationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableReuseIdentifier, for: indexPath)
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.text = dataSource[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationEntity = dataSource[indexPath.row]
        let location = locationEntity.location
        pushWith(vcName: "ShowLocationViewController", vcTitle: location, params: ["location": location as Any])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let locationEntity = dataSource[indexPath.row]
            CoreDataManager.shared.deleteWith(location: locationEntity.location!)
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "删除") { (action, view, finished) in
            CoreDataManager.shared.deleteWith(location: self.dataSource[indexPath.row].location!)
            self.dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            finished(true)
        }
        actionDel.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [actionDel])
    }
    
}

extension LocationViewController: AddLocationViewControllerDelegate {
    
    func didAddLocation() {
        dataSource = CoreDataManager.shared.getAllLocation()
        tableView.reloadData()//刷新数据
    }
    
}
