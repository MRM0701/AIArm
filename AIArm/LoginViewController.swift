//
//  LoginViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "手机号"
        textField.leftView = UIImageView(image: UIImage(systemName: "phone"))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "密码"
        textField.leftView = UIImageView(image: UIImage(systemName: "lock"))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addSubviews()
        layoutSubviews()
    }

    private func addSubviews() {
        contentView.addSubview(phoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        view.addSubview(contentView)
    }

    private func layoutSubviews() {
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }

        phoneTextField.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(0)
        }
    }
    @objc private func loginButtonTapped() {
        // TODO: Add login logic here
        //校验手机号和密码
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            print("手机号不能为空")
            return
        }
        //校验密码
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("密码不能为空")
            return
        }
        
        //调用登录接口
        provider.request(.login(username: phone, password: password)) { (result) in
            switch result {
            case .success(let data):
            //data调用mapjson方法转换成json,使用try?转换成字典
                let json = try? data.mapJSON()
                //尝试把json转换成字典
                guard let jsonDic = json as? [String: Any] else {
                    return
                }
                //获取jsondic中的code和status
                let code = jsonDic["code"] as! Int
                let status = jsonDic["status"] as! Int
                //判断code等于200和status等于0
                if code == 200 && status == 0 {
                    //尝试读取jsondic中的data
                    guard let data = jsonDic["data"] as? [String: Any] else {
                        //打印data不存在
                        print("data不存在")
                        return
                    }
                    //读取data中的token
                    let token = data["token"] as! String
                    //读取data中的userId
                    let userId = data["userId"] as! String
                    //存储token和userId
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(userId, forKey: "userId")
                    //登录成功
                    self.loginSuccess()
                } else {
                    //登录失败设置islogin为false
                    UserDefaults.standard.set(false, forKey: "isLogin")
                    print("登录失败")
                }
            case .failure(let error):
                //登录失败
                print(error)
            }
        }
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


