//
//  CoreDataMacro.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///momd文件路径
let momdUrl = Bundle.main.url(forResource: "MapKitProject", withExtension: "momd")!

///错误信息
let failureReason = "There was an error creating or loading the application's saved data. "

///Document路径
let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!

///sqliteURL文件路径
let sqliteURL = documentDir.appendingPathComponent("MapKitProject.sqlite")
