//
//  FirstViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    /// 项目一
    
    // MARK: - 属性
    
    /// 开始按钮
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.addTarget(self,
                         action: #selector(startAction(sender:)),
                         for: .touchUpInside)
        button.setImage(UIImage(named: "play"),
                        for: .normal)
        return button
    }()
    /// 结束按钮
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.addTarget(self,
                         action: #selector(pauseAction(sender:)),
                         for: .touchUpInside)
        button.setImage(UIImage(named: "pause"),
                        for: .normal)
        return button
    }()
    /// 重置按钮
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self,
                         action: #selector(resetAction(sender:)),
                         for: .touchUpInside)
        return button
    }()
    /// 展示label
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = String.init(format: "%.1f", counter)
        label.font = UIFont.systemFont(ofSize: 100)
        return label
    }()
    /// 定时器
    lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: DispatchTime.now(),
                       repeating: DispatchTimeInterval.seconds(Int(0.1)),
                       leeway: DispatchTimeInterval.milliseconds(40))
        timer.setEventHandler {
            self.timerAction()
        }
        return timer
    }()
    
    /// 计时
    var counter = 0.0
    
    /// 是否在倒计时
    var play = false
    
    /// 是否点击了重置
    var reset = false;
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    /// 试图加载完毕
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - 界面布局
    
    /// 配置UI
    private func setupUI() -> () {
        
        /// 界面样式
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        /// 创建控件
        view.addSubview(startButton)
        view.addSubview(pauseButton)
        view.addSubview(resetButton)
        view.addSubview(label)
        
        /// 布局控件
        startButton.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(pauseButton.snp.left)
            make.height.equalTo(view).multipliedBy(0.6).offset(-TABBAR_HEIGHT()-NAVIGATIONBAR_HEIGHT())
            make.bottom.equalTo(view).offset(-TABBAR_HEIGHT())
        }
        
        pauseButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view)
            make.width.top.height.equalTo(startButton)
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-14)
            make.top.equalTo(view).offset(30+NAVIGATIONBAR_HEIGHT())
            make.width.equalTo(68)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(137)
            make.centerY.equalTo(startButton.snp.top).offset(-(view.frame.size.height * 0.4 / 2))
        }
    }
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    /// 定时器事件
    @objc private func timerAction() -> () {
        counter += 0.1
        label.text = String.init(format: "%.1f", counter)
    }
    
    /// 开始点击事件
    ///
    /// - Parameter sender: 开始按钮
    @objc func startAction(sender: UIButton) -> () {
        
        if self.play {
            return
        }
        
        if counter != 0.0 || reset {
            timer.resume()
            reset = false
        }else{
            timer.activate()
        }
        self.play = true
    }
    
    /// 暂停点击事件
    ///
    /// - Parameter sender: 暂停按钮
    @objc private func pauseAction(sender: UIButton) -> () {
        if self.play {
            timer.suspend()
            self.play = false
        }
    }
    
    /// 重置按钮点击事件
    ///
    /// - Parameter sender: 重置按钮
    @objc private func resetAction(sender: UIButton) -> () {
        if !self.play {
            counter = 0.0
            label.text = String.init(format: "%.1f", counter)
        }else{
            timer.suspend()
            counter = 0.0
            label.text = String.init(format: "%.1f", counter)
            self.play = false
        }
        reset = true
    }
    
    // MARK: - 动画
}
