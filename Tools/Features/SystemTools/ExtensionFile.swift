//
//  ExtensionFile.swift
//  Tools
//
//  Created by LJQ on 2020/3/25.
//  Copyright © 2020 LJQ. All rights reserved.
//

import Foundation
import UIKit
//MARK: StringExtension
extension String {
    //MARK: 字母转大写
    var capital:String {
        return self.uppercased()
    }
    //MARK: 字母转小写
    var lowwercaseStr:String {
        return self.lowercased()
    }
    
    
    //MARK: 判断是否为表情符号
    var containsEmoji:Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x00A0...0x00AF,
                 0x2030...0x204F,
                 0x2120...0x213F,
                 0x2190...0x21AF,
                 0x2310...0x329F,
                 0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    
    //MARK: 获取首字母
    var firstChar:String {
        let mutableStr = NSMutableString(string: self);
        CFStringTransform(mutableStr, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(mutableStr, nil, kCFStringTransformStripDiacritics, false)
        let firsCharactor = mutableStr.capitalized
        return (firsCharactor as NSString).substring(to: 1)
    }
    
}

//MARK: DateExtension
enum DateFormatterENUM {
    case YMD //时间格式 yyyy-MM-dd
    case HMS //时间格式 HH:mm:ss
    case YMDHMS //时间格式 yyyy-MM-dd HH:mm:ss
}

enum TimestampENUM {
    case second //秒
    case millisecond //毫秒
}

extension Date {
    
    /// 获取当前时间
    ///
    /// - Parameter formatterType: 时间格式
    /// - Returns: 时间字符串
    static func getCurrentTime(formatterType:DateFormatterENUM) -> String {
        let formater = DateFormatter()
        switch formatterType {
        case .YMD:
            formater.dateFormat = "yyyy-MM-dd"
        case .HMS:
            formater.dateFormat = "HH:mm:ss"
        default:
            formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        let nowDate = Date()
        return formater.string(from: nowDate as Date)
    }
    
    /// 字符串转Date
    ///
    /// - Parameters:
    ///   - dateStr: 字符串时间
    ///   - dateFormatter: 时间格式
    /// - Returns: 时间Date
    static func stringToDate(dateStr:String, dateFormatter:String) -> NSDate {
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
    static func DateToString(date:NSDate, dateFormatter:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.string(for: date as NSDate)!
    }
    
    /// 获取当前时间时间戳 (秒)
    ///
    /// - Returns: 返回字符串
    static func timeStamp(_ timeType: TimestampENUM) -> String {
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


//MARK: UIImageExtension
extension UIImage {
    
    //MARK: 修改图片旋转
    var fixImg:UIImage {
        if self.imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
        default:
            break
        }
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        return img
    }
}


//MARK: UILabelExtension
extension UILabel {
    
    //MARK: 根据文字计算高度
    var stringLabelHeight:CGFloat {
        if self.text == "" || self.text == nil{
            return 0
        }
        let size = self.text!.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font!], context: nil).size
        return size.height
    }
    
    
    //MARK: 根据文字计算宽度
    var stringLabelWidth:CGFloat {
        if self.text == "" || self.text == nil{
            return 0
        }
        let size = self.text!.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: self.frame.height), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font!], context: nil).size
        return size.width
    }
    
    
    
    //MARK: 文字左右对齐
    func changeLabelLeftAndRight() {
        let textSize = (self.text! as NSString).boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: [NSAttributedString.Key.font: font!], context: nil)
        let margin = (self.frame.width - textSize.width) / CGFloat(self.text!.count - 1)
        let attributeString = NSMutableAttributedString.init(string: self.text!)
        attributeString.addAttributes([(kCTKernAttributeName as NSAttributedString.Key) : margin], range: NSRange(location: 0, length: self.text!.count - 1))
        self.attributedText = attributeString
    }
    
}

//MARK: UIColorExtension
extension UIColor {
    /// 颜色转化
    ///
    /// - Parameters:
    ///   - color: 颜色16进制
    ///   - alpha: 透明图
    /// - Returns: 颜色
    class func hex_color(color:String, alpha:CGFloat) -> UIColor {
        return hexColorWithAlpha(privatecolor: color, privatealpha: alpha)
    }
    
    /// 颜色转化
    ///
    /// - Parameter color: 颜色16进制
    /// - Returns: 颜色
    class func hex_color(color:String) -> UIColor {
        return hexColorWithAlpha(privatecolor: color, privatealpha: 1)
    }
    
    
    private class func hexColorWithAlpha(privatecolor:String, privatealpha:CGFloat) -> UIColor {
        
        var colorString = privatecolor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
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
        
        
        if #available(iOS 13.0, *) {
            
            Scanner(string: rString).scanHexInt32(&r)
            Scanner(string: gString).scanHexInt32(&g)
            Scanner(string: bString).scanHexInt32(&b)
        }else {
            Scanner(string: rString).scanHexInt32(&r)
            Scanner(string: gString).scanHexInt32(&g)
            Scanner(string: bString).scanHexInt32(&b)
        }
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: privatealpha)
        
    }
    
    
    //MARK: 16进制色值转化RGB色值
    class func getRGBColorWithHexColor(hexColor:String, alpha:CGFloat) -> [CGFloat] {
        var colorString = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if colorString.count < 6 {
            return [0,0,0,0]
        }
        
        if colorString.hasPrefix("0x") {
            colorString = (colorString as NSString).substring(from: 2)
        }
        if colorString.hasPrefix("#") {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        if colorString.count != 6 {
            return [0,0,0,0]
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
        
        return [CGFloat(r),CGFloat(g),CGFloat(b),CGFloat(alpha)]
        
        
        
    }
}


enum GestureENUM {
    case tap //点击
    case long //长按
    case pan //拖拽
    case roation //旋转
    case swipe //轻扫
    case pinch //捏合
}
typealias viewAction = (UIGestureRecognizer)->()
extension UIView {
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
            swipe.direction = .down
            self.addGestureRecognizer(swipe)
            self.action = response
        case .pinch:
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            self.addGestureRecognizer(pinch)
            self.action = response
        }
    
    }
    
    //MARK: 设置部分圆角
    func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        self.layer.mask = shape
    }
    
    
    /// 设置View圆角颜色
    func setBorderColor(_ color:UIColor) {
        layer.borderColor = color.cgColor
    }
    
    /// 设置圆角
    func setCornerRadius(_ raidus:CGFloat) {
        layer.cornerRadius = raidus
        setLayerMaskToBounds(true)
    }
    
    /// 设置圆角宽度
    func setBorderWidth(_ width:CGFloat) {
        layer.borderWidth = width
    }
    
    
    
    /// x
    @objc var jq_x: CGFloat {
        get {
            return frame.origin.x
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// y
    @objc var jq_y: CGFloat {
        get {
            return frame.origin.y
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// right
    @objc var jq_right: CGFloat {
        get {
            return frame.size.width + frame.origin.x
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newValue - frame.size.width
            frame = tempFrame
        }
    }
    
    /// bottom
    @objc var jq_bottom: CGFloat {
        get {
            return frame.size.height + frame.origin.y
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newValue - frame.size.height
            frame = tempFrame
        }
    }
    
    /// width
    @objc var jq_width: CGFloat {
        get {
            return frame.size.width
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// height
    @objc var jq_height: CGFloat {
        get {
            return frame.size.height
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    /// size
    @objc var jq_size: CGSize {
        get {
            return frame.size
        }
        set (newValue) {
            var tempFrame : CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    @objc var jq_centerX: CGFloat {
        get {
            return frame.size.width / 2.0
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    @objc var jq_centerY: CGFloat {
        get {
            return frame.size.height / 2.0
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    func setLayerMaskToBounds(_ maskToBounds : Bool) {
        layer.masksToBounds = maskToBounds
        clipsToBounds = maskToBounds
    }
    
}




