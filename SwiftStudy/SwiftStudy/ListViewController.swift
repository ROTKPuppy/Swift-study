//
//  ListViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - 属性
    
    /// tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    /// 数据源
    lazy var dataArray: [String] = {
        let array = ["FirstViewController",
                     "SecondViewController",
                     "ThirdViewController"]
        return array
    }()
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    /// UI布局
    private func setupUI() -> () {
        
        // 添加控件
        view.addSubview(tableView)
        
        // 布局控件
    }
    
    // MARK: - 代理
    
    // MARK: -- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
           cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    // MARK: -- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let string = dataArray[indexPath.row]
        let controller = VCSTRING_TO_VIEWCONTROLLER(string)
        controller?.title = string
        if let controller = controller {
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
            controller.hidesBottomBarWhenPushed = false
        }
    }
    
    // MARK: - 响应事件
    
    // MARK: - 动画

}
