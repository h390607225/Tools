//
//  ViewController.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit
enum MyError : Error {
    case one
    case two
    case three
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AlamofireExtension.share.request(url: "http://www.baidu.com", methodType: .GET, header: true, isUploadPic:true, imgJSON:["file":UIImage.init()]) { (response, isSuccess) in
//
//        }
        
       
        var str = try? testFunc(str: nil)
        print(str)
        
        
        AlamofireExtension.share.request(url: "123", methodType: .POST, parameters: nil, header: true, isUploadPic: false, imgJSON: nil) { (result, isSuccess) in
            LJQPrint("123")
        }
        
        
        
        
        
//        LJQPrint(UIFont.familyNames)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func testFunc(str: String? = nil) throws -> String  {
        if str == "one" {
            throw MyError.one
        }else if str == "two" {
            throw MyError.two
        }else if str == "three" {
            throw MyError.three
        }else if str == nil {
            throw MyError.three
        }
        return "ok"
    }
    
    
    @objc func setUpUI() {
        LJQPrint("通知")
    }
    
    


}

