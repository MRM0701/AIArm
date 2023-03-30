//
//  BaseNavigationController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .black
        navigationBar.isTranslucent = false
    }

}
