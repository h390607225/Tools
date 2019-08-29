//
//  CoreBluetoothExtension.swift
//  Tools
//
//  Created by LJQ on 2019/8/29.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

import CoreBluetooth


/*
 BLECONNECTSTATUS  蓝牙连接状态通知名称
 BLESENDRESPONSE  蓝牙接收到回调通知
 BLESTATUS  蓝牙状态
 
 BLEMACADDRESS  蓝牙mac地址
 BLEWRITEID  蓝牙写入特征值UUID
 BLEREADID  蓝牙读取特征值UUID
 */



let BLECONNECTSTATUS = "BLECONNECTSTATUS"
let BLESENDRESPONSE = "BLESENDRESPONSE"
let BLESTATUS = "BLESTATUS"

let BLEMACADDRESS = ""
let BLEWRITEID = ""
let BLEREADID = ""

//MARK : 蓝牙连接状态
enum BLEConnectStatus {
    case connected
    case disConnect
    case connectError
}

//MARK : 蓝牙状态
enum BLEStatus {
    case unknow
    case resetting
    case unsupported
    case unauthorized
    case poweredOff
    case poweredOn
}



private let manager = CoreBluetoothExtension()
class CoreBluetoothExtension: NSObject , CBCentralManagerDelegate , CBPeripheralDelegate {
    
    
    
    private var bluetoothCenter : CBCentralManager! //蓝牙
    
    
    
    class var share:CoreBluetoothExtension {
        manager.initBluetooth()
        return manager
    }
    
    private func initBluetooth() {
        bluetoothCenter = CBCentralManager.init(delegate: self, queue: nil)
    }
    
    
    
    //MARK: 蓝牙代理方法
    
    //MARK: 更新蓝牙状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            LJQPrint("unknown")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.unknow])
            break
        case .resetting:
            LJQPrint("resetting")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.resetting])
            break
        case .unsupported: //不支持蓝牙
            LJQPrint("unsupported")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.unsupported])
            break
        case .unauthorized: //未获取权限
            LJQPrint("unauthorized")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.unauthorized])
            break
        case .poweredOff: //蓝牙关
            LJQPrint("poweredOff")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.poweredOff])
            break
        case .poweredOn: //蓝牙开
            LJQPrint("powerOn")
            NotificationExtension.postNotification(name: BLESTATUS, object: ["status":BLEStatus.poweredOn])
            central.scanForPeripherals(withServices: nil, options: nil)
            break
            
        default:
            break
        }
    }
    
    
    
}
