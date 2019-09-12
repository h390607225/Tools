//
//  ViewController.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AlamofireExtension.share.request(url: "http://www.baidu.com", methodType: .GET, header: true, isUploadPic:true, imgJSON:["file":UIImage.init()]) { (response, isSuccess) in
//
//        }
        
        
        
        let custom = CustomButtonView.init(fram: CGRect(x: 10, y: 100, width: 10, height: 10), selectImg: "", unSelectImg: "")
        custom.imgSpace = .right
        custom.leftSpace =  10
        custom.textStr = "测试文档"
        self.view.addSubview(custom)
        
        
//        LJQPrint(UIFont.familyNames)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func setUpUI() {
        LJQPrint("通知")
    }
    
    


}

