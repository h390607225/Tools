//
//  UILabelExtension.swift
//  Tools
//
//  Created by ljq on 2019/9/30.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

class UILabelExtension: NSObject {

}
//MARK: UILabel扩展
extension UILabel {
    
    //MARK: 设置文本字体
    func setText(text: String , font: UIFont , color: UIColor) {
        self.text = text
        self.font = font
        self.textColor = color
    }
    
    //MARK: 根据文字计算高度
    func stringLabelHeight() -> CGFloat {
        let size = self.text!.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font!], context: nil).size
        return size.height
    }
    
    //MARK: 根据文字计算宽度
    func stringLabelWidth() -> CGFloat {
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
