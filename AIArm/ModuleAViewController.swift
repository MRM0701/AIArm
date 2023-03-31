import UIKit
import SnapKit
import SwiftyJSON

class MemberCell: UITableViewCell {
    private let avatarImageView = UIImageView()
    private let identityLabel = UILabel()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(60)
        }
        avatarImageView.backgroundColor = .red
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2 //将头像设置为圆形

        contentView.addSubview(identityLabel)
        identityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(15)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        identityLabel.font = UIFont.systemFont(ofSize: 17)
        identityLabel.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(identityLabel.snp.left)
            make.top.equalTo(identityLabel.snp.bottom).offset(5)
            make.right.equalTo(identityLabel.snp.right)
        }
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with member: Member) {
        avatarImageView.image = UIImage(named: member.relativeHead)
        identityLabel.text = member.relativeRel
        nameLabel.text = member.relativeName
    }
}

class ModuleAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.register(MemberCell.self, forCellReuseIdentifier: "MemberCell")
        return tableView
    }()

    private var members = [Member]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        fetchData()
    }

    private func fetchData() {
        //从本地读取userId和groupId字符串，默认为""
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        //使用15981857361登录，groupid为456b15eb-91f8-4357-a7ce-6c4b057ee00b
        let groupId = UserDefaults.standard.string(forKey: "groupId") ?? "456b15eb-91f8-4357-a7ce-6c4b057ee00b"
        provider.request(.getGroupMembers(userId: userId, groupId: groupId)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let json = JSON(data)
                // 解析json数据
                //读取json中的data字段值字典
                let dataDic = json["data"].dictionaryValue
                //读取datadic中的activateRelative数组
                let activateRelativeArray = dataDic["activateRelative"]!.arrayValue
                //self.members = memberArray.map { Member(avatar: $0["avatar"].stringValue, identity: $0["identity"].stringValue, name: $0["name"].stringValue) }
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberCell
        cell.configure(with: members[indexPath.row])
        return cell
    }

}


struct Member {
    let relativeHead: String
    let relativeRel: String
    let relativeName: String
}
