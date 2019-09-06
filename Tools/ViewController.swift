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
        
        AlamofireExtension.share.request(url: "http://www.baidu.com", methodType: .GET, header: true, isUploadPic:true, imgJSON:["file":UIImage.init()]) { (response, isSuccess) in
            
        }
        
        
        
        LJQPrint(UIFont.familyNames)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func setUpUI() {
        LJQPrint("通知")
    }
    
    


}

