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
