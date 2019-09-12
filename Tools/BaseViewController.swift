//
//  BaseViewController.swift
//  Tools
//
//  Created by LJQ on 2019/9/5.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

let backImg = ""//返回按钮图片



class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /// 设置返回按钮
    func setBackBarButton() {
        let backImg = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        backImg.contentMode = .left
        backImg.addGesture(.tap) {[weak self] (response) in
            self?.backAction()
        }
        
        let backBarBtn = UIBarButtonItem.init(customView: backImg)
        self.navigationItem.leftBarButtonItem = backBarBtn
    }
    
    
    /// 设置带文字返回按钮
    func setBackTitleButton() {
        let backView = BackView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let backBarBtn = UIBarButtonItem.init(customView: backView)
        self.navigationItem.leftBarButtonItem = backBarBtn
    }
    
    
    
    
    /// 返回
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// 跳转到VC
    ///
    /// - Parameters:
    ///   - vc: 跳转到的VC
    ///   - isHiddenTabbar: 是否隐藏tabbar
    func pushToVC(vc:UIViewController, isHiddenTabbar:Bool) {
        vc.hidesBottomBarWhenPushed = isHiddenTabbar
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    /// 模态dismiss
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class BackView:UIView {
    
    
    /// 返回图片
    public var backImage:String! {
        set {
            backImg.image = UIImage.init(named: newValue)
        }
        get {
            return ""
        }
    }
    
    /// 返回文字大小
    public var backFont:UIFont! {
        set {
//            backTitleLabel.font = newValue
//            updateFrame()
        }
        get {
            return FONT_31
        }
    }
    
    /// 返回文字颜色
    public var backColor:UIColor {
        set {
            backTitleLabel.textColor = newValue
        }
        get {
            return .lightGray
        }
    }
    
    public var spaceImgWidth:CGFloat! {
        set {
//            updateFrame()
        }
        get {
            return 10
        }
    }
    
    
    private var titleWidth:CGFloat!
    private var backImg:UIImageView!
    private var backTitleLabel:UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        setUpUI()
    }
    
    
    func setUpUI() {
        
        backImg = UIImageView.init()
        self.addSubview(backImg)
        backImg.contentMode = .center
        backImg.backgroundColor = .lightGray
        
        backTitleLabel = UILabel.init()
        self.addSubview(backTitleLabel)
        backTitleLabel.font = backFont
        backTitleLabel.textColor = backColor
        backTitleLabel.text = "返回"
        backTitleLabel.backgroundColor = .purple
        
        LJQPrint(backFont)
        
        titleWidth = backTitleLabel.stringLabelWidth()
        
//        updateFrame()
        
    }
    
    func updateFrame() {
        weak var weakSelf = self
        weakSelf?.frame = CGRect(x: 0, y: 0, width: titleWidth + spaceImgWidth + backImg.frame.width, height: 44)
    }
    
    
    
    
    //MARK: 重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        weak var weakSelf = self
        
        backImg.frame = CGRect(x: 0, y: 0, width: 20, height: weakSelf!.frame.height)
        backTitleLabel.frame = CGRect(x: backImg.frame.width + spaceImgWidth, y: 0, width: backTitleLabel.stringLabelWidth(), height: weakSelf!.frame.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
