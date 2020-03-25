//
//  GCDQueue.swift
//  Tools
//
//  Created by LJQ on 2020/3/25.
//  Copyright © 2020 LJQ. All rights reserved.
//

import UIKit

class GCDQueue: NSObject {
    /// GCD倒计时
    /// - Parameter time: 倒计时时间
    /// - Parameter timing: 剩余秒数
    /// - Parameter ending: 倒计时结束
    class func countDownGCD(_ time:Int, timing:@escaping(String)->(), ending:@escaping()->()) {
        var countDownTime = time
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler {
            countDownTime = countDownTime - 1
            if countDownTime <= 0 {
                timer.cancel()
            }
            DispatchQueue.main.async {
                if countDownTime <= 0 {
                    ending()
                }else {
                    timing("\(countDownTime)")
                }
            }
        }
        timer.resume()
    }
    
    /// GCD 延迟运行
    ///
    /// - Parameters:
    ///   - timer: 延迟时间
    ///   - response: response description
    class func GCDAfter(timer : TimeInterval , response:@escaping()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timer) {
            response()
        }
    }
    
    /// 回归主线程
    ///
    /// - Parameter mainQueue: 主线程执行方法
    class func GCDReturnMainQueue(mainQueue : @escaping(Any)->()) {
        DispatchQueue.main.async {
            mainQueue((Any).self)
        }
        
    }
}
