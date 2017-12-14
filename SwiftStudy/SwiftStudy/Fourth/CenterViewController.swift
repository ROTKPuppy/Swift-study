//
//  CenterViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/14.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    // MARK: - 属性
    
    /// 左侧视图
    lazy var leftViewController: LeftViewController = {
        let viewController = LeftViewController()
        return viewController
    }()
    
    /// 右侧视图
    lazy var rightViewController: RightViewController = {
        let viewController = RightViewController()
        return viewController
    }()
    
    /// 相机视图
    lazy var cameraViewController: CameraViewController = {
        let viewController = CameraViewController()
        return viewController
    }()
    
    /// 滚动视图
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.setContentOffset(CGPoint(x: view.bounds.size.width, y: 0), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    /// 配置界面
    private func setupUI() -> () {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(scrollView)
        
        scrollView.addSubview(leftViewController.view)
        scrollView.addSubview(cameraViewController.view)
        scrollView.addSubview(rightViewController.view)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        leftViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(view)
            make.left.equalTo(scrollView)
        }
        
        cameraViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(leftViewController.view)
            make.left.equalTo(leftViewController.view.snp.right)
        }
        
        rightViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(leftViewController.view)
            make.left.equalTo(cameraViewController.view.snp.right)
            make.right.equalTo(scrollView)
        }
    }
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    // MARK: - 动画

}
