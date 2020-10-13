//
//  ToastView.swift
//  Tools
//
//  Created by LJQ on 2020/3/25.
//  Copyright © 2020 LJQ. All rights reserved.
//

import UIKit

enum ToastSpace {
    case top
    case center
    case bottom
}

class ToastView: UIView {
    
    class func show(msg:String? , space:ToastSpace, inView superView:UIView) {
        
        let toastLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        toastLabel.layer.cornerRadius = 3
        toastLabel.textColor = .white
        toastLabel.text = msg ?? ""
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = .red
        toastLabel.font = FONT_15
        toastLabel.backgroundColor = UIColor.hex_color(color: "000000", alpha: 0.5)
        
        toastLabel.jq_width = toastLabel.stringLabelWidth + GETSCALEWIDTH(40)
        
        if toastLabel.jq_width >= WIDTH - GETSCALEWIDTH(40) {
            toastLabel.jq_width = WIDTH - GETSCALEWIDTH(40)
            toastLabel.numberOfLines = 0
            toastLabel.jq_height = toastLabel.stringLabelHeight
        }
        
        
        switch space {
        case .top:
            LJQPrint("顶部")
            toastLabel.center = CGPoint(x: KEYWINDOW.rootViewController!.view.center.x, y: 100)
        case .center:
            LJQPrint("中间")
            
            toastLabel.center = KEYWINDOW.rootViewController!.view.center
        case .bottom:
            LJQPrint("底部")
            if toastLabel.jq_height / 2 > 100 {
                toastLabel.center = CGPoint(x: KEYWINDOW.rootViewController!.view.center.x, y: KEYWINDOW.rootViewController!.view.frame.height - toastLabel.jq_height / 2 - 100)
            }else {
                toastLabel.center = CGPoint(x: KEYWINDOW.rootViewController!.view.center.x, y: KEYWINDOW.rootViewController!.view.frame.height - 100)
            }
        }
        
        superView.addSubview(toastLabel)
        
        GCDQueue.GCDAfter(timer: 3) {
            toastLabel.removeFromSuperview()
        }
        
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
