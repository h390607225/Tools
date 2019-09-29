//
//  UIColorExtension.swift
//  Tools
//
//  Created by ljq on 2019/9/30.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

class UIColorExtension: NSObject {

}


//MARK: 颜色扩展
extension UIColor {
    
    /// 颜色转化
    ///
    /// - Parameters:
    ///   - color: 颜色16进制
    ///   - alpha: 透明图
    /// - Returns: 颜色
    class func hexColorWithAlpha(color:String, alpha:CGFloat) -> UIColor {
        
        var colorString = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if colorString.count < 6 {
            return UIColor.clear
        }
        
        if colorString.hasPrefix("0x") {
            colorString = (colorString as NSString).substring(from: 2)
        }
        if colorString.hasPrefix("#") {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        if colorString.count != 6 {
            return UIColor.clear
        }
        
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (colorString as NSString).substring(with: range)
        range.location = 2
        let gString = (colorString as NSString).substring(with: range)
        range.location = 4
        let bString = (colorString as NSString).substring(with: range)
        
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0
        
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        
    }
    
    /// 颜色转化
    ///
    /// - Parameter color: 颜色16进制
    /// - Returns: 颜色
    class func hexColor(color:String) -> UIColor {
        var colorString = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if colorString.count < 6 {
            return UIColor.clear
        }
        
        if colorString.hasPrefix("0x") {
            colorString = (colorString as NSString).substring(from: 2)
        }
        if colorString.hasPrefix("#") {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        if colorString.count != 6 {
            return UIColor.clear
        }
        
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (colorString as NSString).substring(with: range)
        range.location = 2
        let gString = (colorString as NSString).substring(with: range)
        range.location = 4
        let bString = (colorString as NSString).substring(with: range)
        
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0
        
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
