//
//  EncryptionTools.swift
//  Tools
//
//  Created by ljq on 2019/10/24.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit
import CommonCrypto
class EncryptionTools: NSObject {
    
    class func md5(strs:String) ->String!{
        let str = strs.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: 0)
        return String(format: hash as String)
    }
    
    // base64编码
    class func toBase64(_ input:String) -> String? {
        let plainData = input.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    // base64解码
    class func fromBase64(_ input:String) -> String? {
        let decodedData = NSData(base64Encoded: input, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
    
    
//    public static func Endcode_AES_ECB(strToEncode:String)->String {
//        // 从String 转成data
//        let data = strToEncode.data(using: String.Encoding.utf8)
//
//        // byte 数组
//        var encrypted: [UInt8] = []
//        do {
//            encrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt(data!.bytes)
//        } catch {
//        }
//
//        let encoded =  Data(encrypted)
//        //加密结果要用Base64转码
//        return encoded.base64EncodedString()
//    }
//
//    //  MARK:  AES-ECB128解密
//    public static func Decode_AES_ECB(strToDecode:String)->String {
//        //decode base64
//        let data = NSData(base64Encoded: strToDecode, options: NSData.Base64DecodingOptions.init(rawValue: 0))
//
//        // byte 数组
//        var encrypted: [UInt8] = []
//        let count = data?.length
//
//        // 把data 转成byte数组
//        for i in 0..<count! {
//            var temp:UInt8 = 0
//            data?.getBytes(&temp, range: NSRange(location: i,length:1 ))
//            encrypted.append(temp)
//        }
//
//        // decode AES
//        var decrypted: [UInt8] = []
//        do {
//            decrypted = try AES(key: key, iv: iv, blockMode:.CBC, padding: PKCS7()).decrypt(encrypted)
//        } catch {
//        }
//
//        // byte 转换成NSData
//        let encoded = Data(decrypted)
//        var str = ""
//        //解密结果从data转成string
//        str = String(bytes: encoded.bytes, encoding: .utf8)!
//        return str
//    }
    
    
}
