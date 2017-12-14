//
//  RightViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/14.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    
    // MARK: - 属性
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let imageView = UIImageView(image: UIImage.init(named: "right"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    // MARK: - 动画

}
