//
//  SystemExtension.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

//MARK: 屏幕宽度
public let WIDTH = UIScreen.main.bounds.width
//MARK: 屏幕高度
public let HEIGHT = UIScreen.main.bounds.height
//MARK: 屏幕frame
public let MAINFRAME = UIScreen.main.bounds
//MARK: 状态栏高度
public let STATEHEIGHT = UIApplication.shared.statusBarFrame.height
//MARK: 状态栏+导航栏高度(为了适配iphone X)
public let NAVHEITH = (UIApplication.shared.statusBarFrame.height + 44)
//MARK: 获取根视图
public let KEYWINDOW = UIApplication.shared.keyWindow
//MARK: 字体类型
public let FontType = "Apple Color Emoji"

//MARK: 甚至文字大小及字体类型
//MARK: 微软雅黑
public let FONT_10 = UIFont(name: FontType, size: 10)
public let FONT_11 = UIFont(name: FontType, size: 11)
public let FONT_12 = UIFont(name: FontType, size: 12)
public let FONT_13 = UIFont(name: FontType, size: 13)
public let FONT_14 = UIFont(name: FontType, size: 14)
public let FONT_15 = UIFont(name: FontType, size: 15)
public let FONT_16 = UIFont(name: FontType, size: 16)
public let FONT_17 = UIFont(name: FontType, size: 17)
public let FONT_18 = UIFont(name: FontType, size: 18)
public let FONT_19 = UIFont(name: FontType, size: 19)
public let FONT_20 = UIFont(name: FontType, size: 20)
public let FONT_21 = UIFont(name: FontType, size: 21)
public let FONT_22 = UIFont(name: FontType, size: 22)
public let FONT_23 = UIFont(name: FontType, size: 23)
public let FONT_24 = UIFont(name: FontType, size: 24)
public let FONT_25 = UIFont(name: FontType, size: 25)
public let FONT_26 = UIFont(name: FontType, size: 26)
public let FONT_27 = UIFont(name: FontType, size: 27)
public let FONT_28 = UIFont(name: FontType, size: 28)
public let FONT_29 = UIFont(name: FontType, size: 29)
public let FONT_30 = UIFont(name: FontType, size: 30)
public let FONT_31 = UIFont(name: FontType, size: 31)


/// 判断是否为iPhoneX以上的设备
///
/// - Returns: bool值
func is_iPhoneX() -> Bool {
    if STATEHEIGHT > 20 {
        return true
    }else {
        return false
    }
}


/// 国际化字符串
/// - Parameter key: key
/// - Parameter comment: 注释
func localString(_ key:String, _ comment:String) -> String {
    return NSLocalizedString(key, comment: comment)
}



/// 设置比例宽度
///
/// - Parameter width: 宽度
/// - Returns: 比例宽度
func GETSCALEWIDTH(width: CGFloat) -> CGFloat {
    let retWidht = width * (WIDTH / 375.0)
    return retWidht
}


//MARK: 自定义输出
func LJQPrint<T> (_ message: T, fileName: String = #file, lineNum: Int = #line) {
    #if DEBUG
    
    let file = (fileName as NSString).lastPathComponent
    print("******************Start*********************\n文件:\(file)\n第\(lineNum)行\n详情:\(message)\n******************End***********************")
    
    
    #endif
}





//MARK: String扩展
extension NSString  {
    
    
    /// 获取首字母
    ///
    /// - Parameter str: 获取目标
    /// - Returns: 返回结果
    func getFirstCharactorWithString(str : String) -> String {
        let mutableStr = NSMutableString(string: str);
        CFStringTransform(mutableStr, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(mutableStr, nil, kCFStringTransformStripDiacritics, false)
        let firsCharactor = mutableStr.capitalized
        return (firsCharactor as NSString).substring(to: 1)
    }
    
    
    
    
    /// 设置需要改变的富文本
    ///
    /// - Parameters:
    ///   - cStr: 需要改变的文本
    ///   - cFont: 需要改变的大小
    ///   - cColor: 需要改变的颜色
    /// - Returns: return value description
    func setAttribute(cStr:String, cFont:UIFont, cColor:UIColor) -> NSAttributedString {
        let attribute = NSMutableAttributedString.init(string: self as String)
        let ranges = self.getStrRanges(str: cStr)
        let dic = NSMutableDictionary.init()
        dic[NSAttributedString.Key.font] = cFont
        dic[NSAttributedString.Key.foregroundColor] = cColor
        for item in ranges {
            attribute.addAttributes(dic as! [NSAttributedString.Key : Any], range: item)
        }
        return attribute
    }
    
    
    /// 获取文字所在该段文字的位置
    ///
    /// - Parameter str: 需要查询的文字
    /// - Returns: return value description
    func getStrRanges(str:String) -> [NSRange] {
        var rangeArr:[NSRange] = []
        var searchRange = NSRange(location: 0, length: self.length)
        var resutlRange:NSRange
        while searchRange.location < self.length {
            searchRange.length = self.length - searchRange.location
            resutlRange = self.range(of: str, options: .caseInsensitive, range: searchRange, locale: nil)
            if resutlRange.location != NSNotFound {
                searchRange.location = resutlRange.location + resutlRange.length
                rangeArr.append(resutlRange)
            }else {
                break
            }
        }
        return rangeArr
    }
    
    
    
    func hexStringFromString(string:String) -> String{
        let myD = string.data(using: .utf8)
        let bytes = [UInt8](myD!)
        
        var hexString = ""
        for (index,_) in (myD?.enumerated())!{
            let newHexString = String(bytes[index] & 0xFF)
            print(newHexString)
            if newHexString.count == 1{
                hexString = hexString + "0" + newHexString
            }else{
                hexString = hexString + newHexString
            }
            
        }
        return hexString
    }
    
    
    
    
    
    
}







//MARK: View扩展
typealias viewAction = (UIGestureRecognizer)->()
extension UIView {
    
    enum GestureENUM {
        case tap //点击
        case long //长按
        case pan //拖拽
        case roation //旋转
        case swipe //轻扫
        case pinch //捏合
    }
    
    private struct AssociatedKeys {
        static var actionKey = "gestureKey"
    }
    
    @objc dynamic var action:viewAction? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? viewAction {
                return action
            }
            return nil
        }
    }
    
    @objc func viewTapAction(gesture: UIGestureRecognizer) {
        if action != nil {
            action!(gesture)
        }
    }
    
    func addGesture( _ gesture : GestureENUM , response:@escaping viewAction) {
        
        self.isUserInteractionEnabled = true
        switch gesture {
        case .tap:
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            tapGesture.numberOfTouchesRequired = 1
            tapGesture.numberOfTapsRequired = 1
            self.addGestureRecognizer(tapGesture)
            self.action = response
        case .long:
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(longPress)
            self.action = response
        case .pan:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(panGesture)
            self.action = response
        case .roation:
            let roation = UIRotationGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(roation)
            self.action = response
        case .swipe:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(swipe)
            self.action = response
        case .pinch:
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(pinch)
            self.action = response
        default:
            LJQPrint("暂无其他手势")
            break
        }
    
    }
    
    
    //MARK: View转图片
    func viewForImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    
    /// 给View设置渐变色
    ///
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - locations: 渐变色比例位置
    ///   - startPoint: 渐变起始位置
    ///   - endPoint: 渐变结束位置
    /// - Returns: return value description
    func getGradientLayer(colors:[CGColor], locations:[NSNumber], startPoint:CGPoint, endPoint:CGPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors//设置渐变颜色
        gradientLayer.locations = locations //渐变发生位置
        gradientLayer.startPoint = startPoint//颜色其实位置
        gradientLayer.endPoint = endPoint//颜色终止位置
        self.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
    
}


extension UIImage {
    
    //MARK: 图片压缩到指定大小(只压缩图片质量,不压缩图片大小, 当压缩到一定大小 ,将不会继续压缩) 该压缩方法性能较慢
    
    /// 图片压缩到指定大小(缩图片质量,不压缩图片大小)
    /// - Parameter maxLength: 图片大小(KB)
    func compressQualityWithMaxLength(maxLength: CGFloat) -> Data{
        let maxBytes = maxLength * 1024
        var compression = 0.9
        let maxCompression = 1.0
        var imgData = self.jpegData(compressionQuality: CGFloat(compression))
        while imgData!.count > Int(maxBytes) && compression > maxCompression {
            compression -= 0.1
            imgData = self.jpegData(compressionQuality: CGFloat(compression))
        }
        LJQPrint(imgData!.count / 1024)
        
        return imgData!
        
    }
    
    //二分压缩法
    //MARK: 图片压缩到指定大小(只压缩图片质量,不压缩图片大小, 当压缩到一定大小 ,将不会继续压缩),该方法性能较高
    
    /// 图片压缩到指定大小(缩图片质量,不压缩图片大小)
    /// - Parameter maxLength: 图片大小(KB)
    func compressImageMid(maxLength: Int) -> Data? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        LJQPrint("压缩前kb: \( Double((data.count)/1024))")
        if data.count < maxLength {
            return data
        }
        print("压缩前kb", data.count / 1024, "KB")
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        
        if data.count < maxLength {
            LJQPrint("成功")
            return data
        }
        return data
    }
}









extension UINavigationController {
    
    
    
    
    
    
}






