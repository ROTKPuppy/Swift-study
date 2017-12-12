//
//  Tool.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

/// 类文件字符串转换为ViewController
///
/// - Parameter childControllerName: VC的字符串
/// - Returns: ViewController
func VCSTRING_TO_VIEWCONTROLLER(_ childControllerName: String) -> UIViewController? {
    
    // 1.获取命名空间
    // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
    guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
        debugPrint("命名空间不存在")
        return nil
    }
    // 2.通过命名空间和类名转换成类
    let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
    
    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
    guard let clsType = cls as? UIViewController.Type else {
        debugPrint("无法转换成UIViewController")
        return nil
    }
    // 3.通过Class创建对象
    let childController = clsType.init()
    
    return childController
}

/// 获取TabBar高度
///
/// - Returns: TabBar高度
func TABBAR_HEIGHT() -> CGFloat {
    let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
    return tabBarController.tabBar.bounds.size.height
}

/// 获取navigationBar高度
///
/// - Returns: navigationBar高度
func NAVIGATIONBAR_HEIGHT() -> CGFloat {
    return 64.0
}
