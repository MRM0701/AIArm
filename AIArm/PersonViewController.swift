//
//  PersonViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit
import SnapKit

class PersonViewController: UIViewController {

    // MARK: - Properties

    private let addPersonButton: UIButton = {
        let button = UIButton()
        button.setTitle("添加就诊人", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()

    private let personListButton: UIButton = {
        let button = UIButton()
        button.setTitle("就诊人列表", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addPersonButton.addTarget(self, action: #selector(addPerson), for: .touchUpInside)
        personListButton.addTarget(self, action: #selector(showPersonList), for: .touchUpInside)

    }

    // MARK: - Selectors

    @objc func addPerson() {
        let addPersonVC = AddPersonViewController()
        addPersonVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addPersonVC, animated: true)
    }

    @objc func showPersonList() {
        let personListVC = PersonListViewController()
        navigationController?.pushViewController(personListVC, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(addPersonButton)
        addPersonButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        view.addSubview(personListButton)
        personListButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}
