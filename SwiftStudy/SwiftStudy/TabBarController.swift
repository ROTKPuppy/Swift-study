//
//  TabBarController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 初始化控制器
extension TabBarController {
    
    func setupViewControllers() -> () {
        
        let viewController = ThirdViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "开发中"
        addChildViewController(navigationController)
        
        let listViewController = ListViewController()
        let navigationController2 = UINavigationController(rootViewController: listViewController)
        navigationController2.title = "展示"
        addChildViewController(navigationController2)
        
    }
}
