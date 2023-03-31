//
//  PersonListViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import UIKit

import UIKit
import Moya
import SwiftyJSON
import Kingfisher

import UIKit
import Moya
import SwiftyJSON
import Kingfisher

class PersonListViewController: BaseViewController {

    let tableView = UITableView()
    var patients = [Patient]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置表格视图的数据源和委托
        tableView.dataSource = self
        tableView.delegate = self

        // 添加到视图
        view.addSubview(tableView)

        // 注册自定义单元格
        tableView.register(PatientTableViewCell.self, forCellReuseIdentifier: "PatientCell")

        // 添加约束
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 请求数据
//        provider.request(.getPatientInfoList) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let data = try response.mapJSON()
//                    let json = JSON(data)
//                    for item in json.arrayValue {
//                        let patient = Patient(json: item)
//                        self.patients.append(patient)
//                    }
//                    self.tableView.reloadData()
//                } catch {
//                    print(error)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
        provider.request(.getPatientInfoList) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    let patients = json["data"]["results"].arrayValue.map { Patient(json: $0) }
                    self.patients = patients
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }


    }

}

extension PersonListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientTableViewCell

//        let patient = patients[indexPath.row]
//
//        cell.patientImageView.kf.setImage(with: URL(string: patient.avatar))
//        cell.nameLabel.text = patient.name
//        cell.idLabel.text = patient.id
//        cell.hospitalLabel.text = patient.hospital
        
        let patient = patients[indexPath.row]

           cell.patientImageView.kf.setImage(with: URL(string: patient.avatar))
           cell.nameLabel.text = patient.name
           cell.idLabel.text = "\(patient.id_card_number)"
           cell.hospitalLabel.text = patient.hospital

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupID = patients[indexPath.row].group_id
        let familyListVC = FamilyListViewController(groupID: groupID)
        self.navigationController?.pushViewController(familyListVC, animated: true)
    }


}

extension PersonListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}




class PatientTableViewCell: UITableViewCell {

    let patientImageView = UIImageView()
    let nameLabel = UILabel()
    let idLabel = UILabel()
    let hospitalLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 添加子视图
        self.contentView.addSubview(patientImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(hospitalLabel)

        // 设置图片视图为圆形
        patientImageView.clipsToBounds = true
        patientImageView.contentMode = .scaleAspectFill
        patientImageView.layer.cornerRadius = 20

        // 设置标签样式
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        idLabel.font = UIFont.systemFont(ofSize: 14)
        hospitalLabel.font = UIFont.systemFont(ofSize: 14)

        // 添加约束
        patientImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(patientImageView.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }

        idLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }

        hospitalLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // 重置图片视图
        patientImageView.image = nil
    }

}


//import Foundation
//import SwiftyJSON
//
//struct Patient {
//    var name: String
//    var id: String
//    var hospital: String
//    var avatar: String
//
//    init(json: JSON) {
//        self.name = json["name"].stringValue
//        self.id = json["id"].stringValue
//        self.hospital = json["hospital"].stringValue
//        self.avatar = json["avatar"].stringValue
//    }
//}


import Foundation
import SwiftyJSON
import Kingfisher

struct Patient {
    var name: String
    var id: String
    var hospital: String
    var avatar: String
    var id_card_number: String
    var group_id: String

    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.hospital = json["hospital_name"].stringValue
        self.avatar = json["avatar_url"].stringValue
        self.id_card_number = json["id_card_number"].stringValue
        self.group_id = json["group_id"].stringValue
    }
}

