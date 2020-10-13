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
    public var leftSpace:CGFloat! { //设置文本距离图片距离
        set {
            spaceWidth = newValue
        }
        get {
            return 20
        }
    }
    
    public var textStr:String! { //设置文本
        set {
            titleLable.text = newValue
        }
        get {
            return ""
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
    
    public var labelNum:Int! {
        set {
            labelNumber = newValue
        }
        get {
            return 1
        }
    }
    
    public var autoHeight:Bool! {
        set {
            titleLable.numberOfLines = 0
            autoH = newValue
        }
        get {
            return false
        }
    }
    
    public var autoWidth:Bool! {
        set{
            autoW = newValue
        }
        get {
            return false
        }
    }
    
    
    
    //MARK: 自有属性
    private var img:UIImageView!
    private var titleLable:UILabel!
    private var space:ImageSpace!
    private var spaceWidth:CGFloat!
    private var autoH:Bool!
    private var autoW:Bool!
    private var labelNumber:Int!
    
    
    

    public init (fram: CGRect, selectImg: String , unSelectImg: String) {
        super.init(frame: fram)
        setUpUI()
    }
    
    
    func setUpUI() {
        
        
        img = UIImageView.init()
        self.addSubview(img)
        img.backgroundColor = .red
        
        
        titleLable = UILabel.init()
        self.addSubview(titleLable)
        titleLable.backgroundColor = .lightGray
        
        self.backgroundColor = .purple
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch space {
        case .right?:
            img.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            titleLable.frame = CGRect(x: img.frame.width + spaceWidth, y: 0, width: titleLable.stringLabelWidth, height: titleLable.stringLabelHeight)
            self.frame.size = imgOrLabelBig()
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
    
    //MARK: 根据文字判定父视图大小
    func imgOrLabelBig() -> CGSize {
        if titleLable.stringLabelHeight > img.frame.height {
            return CGSize(width: titleLable.frame.width + spaceWidth + img.frame.width, height: titleLable.frame.height)
        }else {
            return CGSize(width: titleLable.frame.width + spaceWidth + img.frame.width, height: img.frame.height)
        }
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
