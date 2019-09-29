//
//  AlamofireExtension.swift
//  Tools
//
//  Created by LJQ on 2019/8/30.
//  Copyright © 2019 LJQ. All rights reserved.
//

/*
 遗留问题:
 https证书校验的sessionManager与网络请求不是一个,待解决
 */


import UIKit
import Alamofire
import SwiftyJSON
//MARK: 请求超时时间
public let timeoutRequest:TimeInterval = 20
//MARK: 监听的网络
public let listenHost:String = "https://www.baidu.com"
//MARK: 请求成功码
public let successCode:String = ""
//MARK: 请求域名
private let baseURL:String = ""
//MARK: 单张上传图片fileName
private let fileName:String = String.init(describing: NSDate()) + ".png"
//MARK: 多张图片上传fileName
private let fileArrayName:String = String.init(describing: NSDate()) + ".png"

private let imgScal:CGFloat = 1

private let shareManager = AlamofireExtension()


//MARK: 请求格式
enum RequestType {
    case POST
    case GET
    case PUT
    case DELETE
    case HEAD
    case PATCH
    case TRACE
    case CONNECT
    case OPTIONS
}
//MARK: 网络连接状态
enum NetworkingType {
    case WIFI
    case WWAN
    case unKonw
}

private let shareSessionManager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = timeoutRequest
    return Alamofire.SessionManager(configuration: configuration)
}()


//MARK: 请求回调
typealias ResultBlock = (_ success:Bool ,_ result:JSON?, _ error: JSON?) -> Void



class AlamofireExtension: NSObject {
    
    //MARK: 创建单例
    class var share : AlamofireExtension {
        return shareManager
    }
    
    //MARK: 对外网络请求
    func request(url:String, methodType: RequestType, parameters:[String: Any]? = nil, header: Bool , isUploadPic:Bool? = nil, imgJSON:[UIImage]? = nil, result:@escaping((JSON, Bool)->())) {
        
        
        AlamofireExtension.share.startListen_Networking {[weak self] (netType) in
            switch netType {
            case .WIFI:
                LJQPrint("wifi连接")
                
                self!.privateRequst(url: url, methodType: methodType, parameters: parameters, header: header, isUploadPic: isUploadPic, imgJSON: imgJSON) { (response, isSuccess) in
                    result(response, isSuccess)
                }
                
            case .WWAN:
                LJQPrint("应该询问4G网络连接是否继续上传")
                self!.privateRequst(url: url, methodType: methodType, parameters: parameters, header: header, isUploadPic: isUploadPic, imgJSON: imgJSON) { (response, isSuccess) in
                    result(response, isSuccess)
                }
                
            default:
                
                LJQPrint("无网络连接,显示无数据View")
            }
        }
    }
    
    
    //MARK: 网络请求分类
    private func privateRequst(url:String, methodType: RequestType, parameters:[String: Any]? = nil, header: Bool , isUploadPic:Bool? = nil, imgJSON:[UIImage]? = nil, result:@escaping((JSON, Bool)->())) {
        if getIsUploadPic(isUploadPic: isUploadPic) {
            LJQPrint("上传图片")
            shareManager.uploadPic(url: url, picArr: imgJSON!, headers: header, parameters: parameters) { (response, isSuccess) in
                result(response, isSuccess)
            }
        }else {
            LJQPrint("网络请求")
            shareManager.requestURL(url: url, methodType: methodType, parameters: parameters, header: header, result: { (response, isSuccess) in
                result(response, isSuccess)
            })
        }
    }
    
    
    
    
    
    //MARK: 内部网络请求
    private func requestURL(url: String, methodType:RequestType, parameters:[String:Any]? = nil ,header:Bool? = nil, result:@escaping((JSON, Bool))->()) {
        
        var httpHeader:HTTPHeaders?
        if getIsHeader(isHeader: header) {
            httpHeader = configHeader(headers: ["key":"value"])
        }
        
        let requestURL = getRequestURL(url: url)
        
        shareSessionManager.request(requestURL, method: configMethod(methodType: methodType), parameters: parameters, encoding: JSONEncoding.default, headers: httpHeader).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let responseJson = JSON(value)
                
                if responseJson["code"].stringValue == successCode {
                    result((responseJson,true))
                }else {
                    result((responseJson,false))
                }
                
                
                LJQPrint(value)
            case .failure(let error):
                
                let responseError = error
                result((["error":responseError],false))
                LJQPrint(error)
            }
        }
    }
    
    //MARK: 图片上传
    private func uploadPic(url: String, picArr:[UIImage], headers:Bool, parameters: [String: Any]? = nil, result:@escaping(JSON, Bool)->()) {
        
        var httpHeader:HTTPHeaders!
        if getIsHeader(isHeader: headers) {
            httpHeader = configHeader(headers: ["key":"value"])
        }
        
        
        shareSessionManager.upload(multipartFormData: {[weak self] (multipartFormData) in
            
            if picArr.count == 1 {
                let img = picArr.first
                let imgData = img!.jpegData(compressionQuality: imgScal)
                multipartFormData.append(imgData!, withName: fileName, mimeType: "image/png")
            }else if picArr.count >= 1 {
                for image:UIImage in picArr {
                    let imgData = image.jpegData(compressionQuality: imgScal)
                    multipartFormData.append(imgData!, withName: fileName, fileName: fileName, mimeType: "image/png")
                }
            }
            
            if ((try? self!.configParameters(parame: parameters)) != nil) {
                for (key, value) in parameters! {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
        }, to: getRequestURL(url: url),
           headers:httpHeader) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    if response.result.isSuccess {
                        let resp = JSON(response.result.value as Any)
                        LJQPrint(resp)
                        
                    }else {
                        
                    }
                }
            case .failure(let encodingError):
                LJQPrint(encodingError)
            }

        }
    }
    
    //MARK: 获取请求地址
    private func getRequestURL(url:String) -> String {
        let requestURL:String = baseURL + url
        return requestURL
    }
    
    
    
    //MARK: 请求参数
    private func configParameters(parame: [String: Any]? = nil) throws -> [String: Any]? {
        let paramerts:[String: Any]!
        paramerts = parame
        return paramerts
        
    }
    
    
    //MARK: 设置请求头
    private func configHeader(headers:[String: String]) -> HTTPHeaders {
        var httpHeader:HTTPHeaders!
        httpHeader = headers
        return httpHeader!
    }
    
    
    //MARK: 设置请求类型
    private func configMethod(methodType:RequestType) -> HTTPMethod {
        
        let method:HTTPMethod
        switch methodType {
        case .GET:
            method = HTTPMethod.get
        case .POST:
            method = HTTPMethod.post
        case .PUT:
            method = HTTPMethod.put
        case .DELETE:
            method = HTTPMethod.delete
        case .TRACE:
            method = HTTPMethod.trace
        case .CONNECT:
            method = HTTPMethod.connect
        case .HEAD:
            method = HTTPMethod.head
        case .OPTIONS:
            method = HTTPMethod.options
        case .PATCH:
            method = HTTPMethod.patch
        }
        return method
    }
    
    
    //MARK: 判断是否上传图片
    private func getIsUploadPic(isUploadPic: Bool?) -> Bool {
        
        if isUploadPic == nil {
            return false
        }
        
        return isUploadPic!
    }
    
    //MARK: 判断是否设置是header
    private func getIsHeader(isHeader: Bool?) -> Bool {
        
        if isHeader == nil {
            return false
        }
        
        return isHeader!
    }
    
    
    
    //MARK: 监听网络通信状态
    func startListen_Networking(networkType:@escaping((NetworkingType))->()) {
        let networManager = NetworkReachabilityManager(host: listenHost)
        //每次进行网络请求,都会验证网络状态.
        networManager?.listener = { status in
            if status == .reachable(.ethernetOrWiFi) {
                networkType(NetworkingType.WIFI)
                LJQPrint("WIFI")
            }else if status == .reachable(.wwan) {
                networkType(NetworkingType.WWAN)
                LJQPrint("蜂窝网络")
            }else if status == .notReachable {
                networkType(NetworkingType.unKonw)
                LJQPrint("无网络连接")
            }else {
                networkType(NetworkingType.unKonw)
                LJQPrint("无网络连接")
            }
            
        }
        networManager?.startListening()
    }
    
    
    
    
    
    //MARK: https证书校验
    func setAlamofireHttps() {
        SessionManager.default.delegate.sessionDidReceiveChallenge = {(session: URLSession, challenge: URLAuthenticationChallenge)in
            let method = challenge.protectionSpace.authenticationMethod
            
            if method == NSURLAuthenticationMethodServerTrust {
                LJQPrint("服务端证书认证")
                return AlamofireExtension.trustServerWithCer(challenge: challenge)
            }else if method == NSURLAuthenticationMethodClientCertificate {
                LJQPrint("客户端认证")
                return AlamofireExtension.sendClientCer()
            }else {
                LJQPrint("不通过验证")
                return (.cancelAuthenticationChallenge, nil)
            }
            
        }
    }
    
    
    //不做任何验证，直接信任服务器
    static private func trustServer(challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
        let disposition = URLSession.AuthChallengeDisposition.useCredential
        let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        return (disposition, credential)
        
    }
    
    
    //验证服务器证书
    static private func trustServerWithCer(challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
        var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
        var credential: URLCredential?
        
        
        //获取服务器发送过来的证书
        let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!//证书链
        //获取本地证书
        let localCertificates = ServerTrustPolicy.certificates(in: Bundle.main)
        
        let securityPolicy = ServerTrustPolicy.pinCertificates(certificates: localCertificates, validateCertificateChain: true, validateHost: true)
        
        if securityPolicy.evaluate(serverTrust, forHost: challenge.protectionSpace.host) {
            LJQPrint("验证成功")
            disposition = URLSession.AuthChallengeDisposition.useCredential
            credential = URLCredential(trust: serverTrust)
        }else {
            LJQPrint("验证失败")
            disposition = URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge
        }

        return (disposition, credential)
        
    }
    
    //发送客户端证书交由服务器验证
    static private func sendClientCer() -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
        let disposition = URLSession.AuthChallengeDisposition.useCredential
        var credential: URLCredential?
        
        //获取项目中P12证书文件的路径
        let path: String = Bundle.main.path(forResource: "你本地的p12证书文件名", ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile:path)!
        let key : NSString = kSecImportExportPassphrase as NSString
        let options : NSDictionary = [key : "p12证书的密码"] //客户端证书密码
        
        var items: CFArray?
        let error = SecPKCS12Import(PKCS12Data, options, &items)
        
        if error == errSecSuccess {
            
            let itemArr = items! as Array
            let item = itemArr.first!
            
            let identityPointer = item["identity"];
            let secIdentityRef = identityPointer as! SecIdentity
            
            let chainPointer = item["chain"]
            let chainRef = chainPointer as? [Any]
            
            credential = URLCredential.init(identity: secIdentityRef, certificates: chainRef, persistence: URLCredential.Persistence.forSession)
            
        }
        
        return (disposition, credential)
        
    }
}
