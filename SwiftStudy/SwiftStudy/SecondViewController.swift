//
//  SecondViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - 属性
    
    /// 字体下标
    var fontIndex = 0
    
    /// 数据源
    let data = ["30 Days Swift",
                "这些字体特别适合打「奋斗」和「理想」",
                "谢谢「造字工房」，本案例不涉及商业使用",
                "使用到造字工房劲黑体，致黑体，童心体",
                "呵呵，再见🤗 See you next Project",
                "微博 @Allen朝辉",
                "测试测试测试测试测试测试",
                "123",
                "Alex",
                "@@@@@@"]
    
    /// 字体名称数据
    let fontNames = ["AlNile",
                     "LaoSangamMN",
                     "BradleyHandITCTT-Bold",
                     "HiraMinProN-W3",
                     "PingFangHK-Medium"]
    
    /// 内容视图
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 35
        return tableView
    }()
    
    /// 底部按钮
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.9720721413, blue: 0.434499579, alpha: 1)
        button.setTitle("Change Button", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.layer.cornerRadius = 55
        button.addTarget(self,
                         action: #selector(changeButtonAction(sender:)),
                         for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "AlNile", size: 12)
        return button
    }()
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family){
                debugPrint(font)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    private func setupUI() -> () {
        
        // 界面配置
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // 添加控件
        view.addSubview(tableView)
        view.addSubview(changeButton)
        
        // 布局控件
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 110, height: 110))
            make.bottom.equalTo(view).offset(-38)
            make.centerX.equalTo(view)
            make.top.equalTo(tableView.snp.bottom).offset(71)
        }
    }
    
    // MARK: - 代理
    
    // MARK: -- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = data[indexPath.row]
        cell?.textLabel?.font = UIFont(name: fontNames[fontIndex], size: 16)
        cell?.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell!
    }
    
    // MARK: -- UITableViewDelegate
    
    // MARK: - 响应事件
    
    /// 更换字体点击事件
    ///
    /// - Parameter sender: 更换字体按钮
    @objc private func changeButtonAction(sender: UIButton) -> () {
        fontIndex = (fontIndex + 1) % 5
        tableView.reloadData()
    }
    
    // MARK: - 动画

}
