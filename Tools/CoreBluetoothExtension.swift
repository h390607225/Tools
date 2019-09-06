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
    private var nowPeripheral:CBPeripheral!//当前外设
    private var serverPeripheral:CBPeripheral!//service外设
    private var peripheralList:NSMutableArray!//设备组
    private var cPeripheral:CBPeripheral!//characteristic外设
    private var writeCharacteristic:CBCharacteristic! //写特征值
    private var readCharacteristic:CBCharacteristic! //读特征值
    
    
    class var share:CoreBluetoothExtension {
        manager.initBluetooth()
        return manager
    }
    
    private func initBluetooth() {
        LJQPrint("蓝牙初始化")
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
    
    //MARK: 蓝牙已经连接
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        nowPeripheral = peripheral
        NotificationExtension.postNotification(name: BLECONNECTSTATUS , object: ["status": BLEConnectStatus.connected])
    }
    
    //MARK: 蓝牙连接错误
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        NotificationExtension.postNotification(name: BLECONNECTSTATUS, object: ["status":BLEConnectStatus.connectError])
    }
    
    //MARK: 发现服务回调
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        nowPeripheral = peripheral
        let macData = advertisementData["kCBAdvDataManufacturerData"] as? Data
        
        if macData != nil {
//            let macAddress = NSString.init().coverData(toHexStr: macData!)
//
//            if macAddress == BLEMACADDRESS {
//
//                central.connect(peripheral, options: nil)
//                central.stopScan()
//            }
            
        }
        
    }
    
    //MARK: 蓝牙取消与外设连接回调
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        NotificationExtension.postNotification(name: BLECONNECTSTATUS , object: ["status":BLEConnectStatus.disConnect])
    }
    
    //MARK: 蓝牙与应用状态同步
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }
    
    
    //MARK: 外设代理方法
    
    //MARK: 匹配一个服务的UUID
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if (error != nil) {
            LJQPrint("扫描外设出错 \(String(describing: peripheral.name)), \(error?.localizedDescription)")
            return
        }
        
        self.serverPeripheral = peripheral
            LJQPrint("扫描到外设服务 \(peripheral.name), \(peripheral.services)")
        for service:CBService in peripheral.services! {
            self.nowPeripheral.discoverCharacteristics(nil, for: service)
        }
        
        
    }
    
    //MARK: 服务特征值
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if (error != nil) {
            LJQPrint("扫描外设的特征值失败: \(peripheral.name), \(service.uuid.uuidString), \(service.characteristics)")
            return
        }
        for characteristic:CBCharacteristic in service.characteristics! {
            peripheral.setNotifyValue(true, for: characteristic)
            if characteristic.uuid.uuidString == BLEWRITEID {
                writeCharacteristic = characteristic
            }
            
            if characteristic.uuid.uuidString == BLEREADID {
                readCharacteristic = characteristic
            }
        }
    }
    
    //MARK: 特征值改变会走这个回调
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid.uuidString == BLEREADID {

            NotificationExtension.postNotification(name: BLESENDRESPONSE, object: ["msg":characteristic])

        }
        
    }
    
    //MARK: 蓝牙写入消息
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    
}
