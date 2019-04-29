//
//  CoreDataManager.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()
    
    ///获取NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        let context = (UIApplication.shared.delegate as! AppDelegate).context
        return context
    }()
    
    ///更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    ///增加数据
    /*
     首先运用NSEntityDescription创建出LocationEntity
     然后为LocationEntity赋值，最终调用saveContext()方法保存数据
     */
    func saveLocationWith(location: String) {
        let locationEntity = NSEntityDescription.insertNewObject(forEntityName: "LocationEntity", into: context) as! LocationEntity
        locationEntity.location = location
        saveContext()//save数据
    }
    
    ///获取所有数据
    /*
    如果是通过系统自动生成的CoreData文件，LocationEntity会自带一个fetchRequest()的方法，我们可以直接通过LocationEntity()的方式拿到LocationEntity的NSFetchRequest对象
     然后通过context的fetch(fetchRequest)方法拿到数据数组
     */
    func getAllLocation() -> [LocationEntity] {
        let fetchRequest: NSFetchRequest = LocationEntity.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            print("获取所有数据result = \(result)")
            return result
        } catch {
            fatalError()
        }
    }
    
    ///根据条件删除数据
    /*
     与修改数据一样，首先拿到符合删除条件的数据
     循环调用context的delete()方法就可以了
     最后别忘记save
     */
    func deleteWith(location: String) {
        let fetchRequest: NSFetchRequest = LocationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "location = %@", location)
        do {
            let result = try context.fetch(fetchRequest)
            for locationEntity in result {
                context.delete(locationEntity)
            }
        } catch {
            fatalError()
        }
        saveContext()//save数据
    }
    
    ///删除所有数据
    /*
     获取所有数据
     循环删除
     save
     */
    func deleteAllLocation() {
        //这里直接调用上面获取所有数据的方法
        let result = getAllLocation()
        //循环删除所有数据
        for locationEntity in result {
            context.delete(locationEntity)
        }
        saveContext()//save数据
    }
    
}
