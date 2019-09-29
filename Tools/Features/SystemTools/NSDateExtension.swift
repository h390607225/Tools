//
//  NSDateExtension.swift
//  Tools
//
//  Created by ljq on 2019/9/30.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

enum DateFormatterENUM {
    case YMD //时间格式 yyyy-MM-dd
    case HMS //时间格式 HH:mm:ss
    case YMDHMS //时间格式 yyyy-MM-dd HH:mm:ss
}

enum TimestampENUM {
    case second
    case millisecond
}

class NSDateExtension: NSObject {

}


//MARK: Date扩展
extension NSDate {
    
    
    /// 获取当前时间
    ///
    /// - Parameter formatterType: 时间格式
    /// - Returns: 时间字符串
    class func getCurrentTime(formatterType:DateFormatterENUM) -> String {
        let formater = DateFormatter()
        switch formatterType {
        case .YMD:
            formater.dateFormat = "yyyy-MM-dd"
        case .HMS:
            formater.dateFormat = "HH:mm:ss"
        default:
            formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        let nowDate = NSDate()
        return formater.string(from: nowDate as Date)
    }
    
    /// 字符串转Date
    ///
    /// - Parameters:
    ///   - dateStr: 字符串时间
    ///   - dateFormatter: 时间格式
    /// - Returns: 时间Date
    class func stringToDate(dateStr:String, dateFormatter:String) -> NSDate {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.date(from: dateStr)! as NSDate
    }
    
    /// Date转字符串
    ///
    /// - Parameters:
    ///   - date: 时间戳
    ///   - dateFormatter: 时间格式
    /// - Returns: 时间字符串
    class func DateToString(date:NSDate, dateFormatter:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.string(for: date as NSDate)!
    }
    
    /// 获取当前时间时间戳 (秒)
    ///
    /// - Returns: 返回字符串
    class func timeStamp(_ timeType: TimestampENUM) -> String {
        let timeInterval:TimeInterval = self.init().timeIntervalSince1970
        let timeStamp:Int!
        switch timeType {
        case .second:
            timeStamp = Int(timeInterval)
        default:
            timeStamp = CLong(timeInterval * 1000)
        }
        return "\(String(describing: timeStamp!))"
    }
}

