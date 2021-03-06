//
//  NotificationExtension.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

//MARK: 命名规则 : 工程名称 + 公司简称 + 版本号 + 功能

let LJQNotification = "Tool_Neusoft_1.0_Notification" //示例



//MARK: NotificationCenterExtension
extension NotificationCenter {
    
    //MARK: 发送通知
    class func postNotification(name: String , object: Any? = nil , userInfo: [AnyHashable: Any]? = nil) {
        if userInfo == nil {
            self.default.post(name: NSNotification.Name(rawValue: name), object: object)
        }else {
            self.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
    }
    
    //MARK: 接收通知
    class func addObserver(observer: Any , selector: Selector , name: String , object: Any?) {
        self.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    
    //MARK: 移除通知
    class func deleteNotification(id: Any) {
        self.default.removeObserver(id)
    }
}
