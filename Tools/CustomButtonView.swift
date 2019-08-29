//
//  CustomButtonView.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//  按钮创建

import UIKit

enum ImageSpace {
    case left
    case right
    case top
    case bottom
}



class CustomButtonView: UIView {
    
    //MARK: 开放属性
    public var leftSpace:CGFloat! {
        set {
            
        }
        get {
            return 20
        }
    }
    
    public var imgSpace:ImageSpace! { //图片在view中的位置方向(默认在View的左侧)
        set {
            space = newValue
        }
        get {
            return ImageSpace.left
        }
    }
    
    
    
    
    
    //MARK: 自有属性
    private var img:UIImageView!
    private var titleLable:UILabel!
    private var space:ImageSpace!
    

    public init (fram: CGRect, selectImg: String , unSelectImg: String) {
        super.init(frame: fram)
        setUpUI()
    }
    
    
    func setUpUI() {
        
        
        img = UIImageView.init()
        self.addSubview(img)
        
        
        titleLable = UILabel.init()
        self.addSubview(titleLable)
        
        
        
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch space {
        case .right?:
            print("右侧")
            break
        case .top?:
            print("上侧")
            break
        case .bottom?:
            print("下方")
            break
        default:
            print("左侧")
            break
        }
        
        
        LJQPrint("文字输出")
        
        
        img.frame.offsetBy(dx: leftSpace, dy: 0)
//        img.frame.
        
        
        
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
