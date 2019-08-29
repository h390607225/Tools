//
//  CustomLableView.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit





class CustomLableView: UIView {
    //MARK: 开放属性
    public var alignLeftAndRight:Bool! {
        set {
            
        }
        get {
            return false
        }
    }
    
    
    

    //MARK: 固定宽度,自适应高度
    public init(frame: CGRect, fixedWidth: CGFloat) {
        super.init(frame: frame)
    }
    
    //MARK: 固定高度, 自适应宽度
    public init(frame: CGRect, fixedHeight: CGFloat) {
        super.init(frame: frame)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
