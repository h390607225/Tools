//
//  ViewController.swift
//  Tools
//
//  Created by LJQ on 2019/8/28.
//  Copyright © 2019 LJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var testTitleList:[[String]] = [["NotificationExtension","UserDefaultExtension"],
                                    ["AlamofireExtension","SocketExtension"],
                                    ["CoreDataExtension","plist","FMDBExtension"],
                                    ["BluetoothExtension"]]
    
    var sectionTitle:[String] = ["系统工具","网络连接","文件管理","硬件调用"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LJQPrint(UIFont.familyNames)
        
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    //MARK: tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTitleList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexCell = "indexCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indexCell)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: indexCell)
        }
//        cell?.textLabel?.text = NSLocalizedString("key", comment: "")
        cell?.textLabel?.text = testTitleList[indexPath.section][indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
    lazy var tableView:UITableView = {[weak self] in
        let tableview = UITableView.init(frame: self!.view.frame, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
        }()
    
    
}

