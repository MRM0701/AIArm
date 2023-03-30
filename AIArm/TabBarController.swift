//
//  TabBarController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let personVC = PersonViewController()
        personVC.title = "就诊人"
        personVC.tabBarItem = UITabBarItem(title: "就诊人", image: UIImage(named: "person"), selectedImage: UIImage(named: "person_selected"))
        let moduleAVC = ModuleAViewController()
        moduleAVC.title = "模块A"
        moduleAVC.tabBarItem = UITabBarItem(title: "模块A", image: UIImage(named: "moduleA"), selectedImage: UIImage(named: "moduleA_selected"))
        let moduleBVC = ModuleBViewController()
        moduleBVC.title = "模块B"
        moduleBVC.tabBarItem = UITabBarItem(title: "模块B", image: UIImage(named: "moduleB"), selectedImage: UIImage(named: "moduleB_selected"))
        let moduleCVC = ModuleCViewController()
        moduleCVC.title = "模块C"
        moduleCVC.tabBarItem = UITabBarItem(title: "模块C", image: UIImage(named: "moduleC"), selectedImage: UIImage(named: "moduleC_selected"))
        let nav1 = BaseNavigationController(rootViewController: personVC)
        let nav2 = BaseNavigationController(rootViewController: moduleAVC)
        let nav3 = BaseNavigationController(rootViewController: moduleBVC)
        let nav4 = BaseNavigationController(rootViewController: moduleCVC)
        viewControllers = [nav1, nav2, nav3, nav4]
    }

}
