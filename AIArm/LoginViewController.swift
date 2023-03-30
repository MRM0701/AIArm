//
//  LoginViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            // Add login page
            // ...
            let loginButton = UIButton()
            loginButton.setTitle("Login", for: .normal)
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.backgroundColor = .blue
            loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
            view.addSubview(loginButton)
            loginButton.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
        }

        @objc func loginButtonTapped() {
            // Simulate login success
            loginSuccess()
        }

        func loginSuccess() {
            // Save login success status
            UserDefaults.standard.set(true, forKey: "isLogin")
            // Switch to main interface
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let tabBarController = TabBarController()
            tabBarController.tabBar.backgroundColor = .white
            tabBarController.tabBar.barTintColor = .white
            tabBarController.tabBar.shadowImage = UIImage() //去掉tabbar顶部的细线（阴影效果）
            let array = UIApplication.shared.connectedScenes
            let delegate  = array.first?.delegate as? SceneDelegate
            delegate?.window?.rootViewController = tabBarController
        }

}
