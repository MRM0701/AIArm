//
//  FamilyListViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/31.
//

import UIKit
import UIKit
import Moya
import SwiftyJSON
import Kingfisher

class FamilyListViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        var families = [Family]()

        let groupID: String

        init(groupID: String) {
            self.groupID = groupID
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            // 设置集合视图的数据源和委托
            collectionView.dataSource = self
            collectionView.delegate = self

            // 添加到视图
            view.addSubview(collectionView)

            // 注册自定义单元格
            collectionView.register(FamilyCollectionViewCell.self, forCellWithReuseIdentifier: "FamilyCell")

            // 添加约束
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            // 设置集合视图的布局
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 100, height: 150)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10

            // 请求数据
//            provider.request(.getFamilyList(groupID: groupID)) { result in
//                switch result {
//                case let .success(response):
//                    do {
//                        let data = try response.mapJSON()
//                        let json = JSON(data)
//                        for item in json.arrayValue {
//                            let family = Family(json: item)
//                            self.families.append(family)
//                        }
//                        self.collectionView.reloadData()
//                    } catch {
//                        print(error)
//                    }
//                case let .failure(error):
//                    print(error)
//                }
//            }
            
            provider.request(.searchAllArmbandGroup(groupId: groupID)) { result in
                switch result {
                case let .success(response):
                    let data = response.data
                    let json = JSON(data)
                    for item in json.arrayValue {
                        let family = Family(json: item)
                        self.families.append(family)
                    }
                    self.collectionView.reloadData()
                case let .failure(error):
                    print(error)
                }
            }
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return families.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyCell", for: indexPath) as! FamilyCollectionViewCell
            let family = families[indexPath.item]
            cell.imageView.image = family.member.image
            cell.nameLabel.text = family.member.name
            return cell
        }
    
    

    }
class FamilyCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 添加子视图
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        // 添加约束
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }

        // 配置子视图
        imageView.contentMode = .scaleAspectFill
        nameLabel.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 配置单元格的内容
    func configure(with member: FamilyMember) {
        imageView.image = member.image
        nameLabel.text = member.name
    }
}

struct Family {
    let member: FamilyMember
    let relationship: String

    init(json: JSON) {
        member = FamilyMember(json: json["member"])
        relationship = json["relationship"].stringValue
    }
}

struct FamilyMember {
    let name: String
    let image: UIImage

    init(json: JSON) {
        name = json["name"].stringValue
        image = UIImage(named: json["image"].stringValue)!
    }
}
