//
//  NSUserDefaultExtension.swift
//  Tools
//
//  Created by ljq on 2019/9/29.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

let UserDefaultsKey = "UserDefaultsKey"








extension UserDefaults {
    class func setKeyValue(key:String,value:Any?) {
        guard value == nil else {
            self.standard.set(value, forKey: key)
            return
        }
        print("value值为空")
    }
    
    class func removeKey(key: String) {
        self.standard.removeObject(forKey: key)
    }
    
    class func getValueForKey(key: String) -> Any? {
        return self.standard.object(forKey: key)
    }
    
}
