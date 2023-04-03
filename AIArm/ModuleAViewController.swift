import UIKit
import SnapKit
import SwiftyJSON

class MemberCell: UITableViewCell {
    private let avatarImageView = UIImageView()
    private let identityLabel = UILabel()
    private let nameLabel = UILabel()
    let cRelativeNnumArray = ["1","2","3","4","5","6","7","8","9","10","11","12","0"]
    let cRelativeArray = ["爸爸","妈妈","爷爷","奶奶","外婆","外公","哥哥","姐姐","叔叔","阿姨","伯父","伯母","监护人"]
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
        avatarImageView.layer.cornerRadius = 30 //将头像设置为圆形
        avatarImageView.layer.masksToBounds = true


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
        //avatarImageView使用kingfisher加载图片
        avatarImageView.kf.setImage(with: URL(string: member.relativeHead))
        //从cRelativeNnumArray数组中查找member.relativeRel的下标
        let index = cRelativeNnumArray.firstIndex(of: member.relativeRel)
        //如果index不为nil，从cRelativeArray数组中取出下标为index的元素赋值给identityLabel.text
        identityLabel.text = index != nil ? cRelativeArray[index!] : member.relativeRel
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
                //读取code字段值
                let code = json["code"].intValue
                //读取status字段值
                let status = json["status"].intValue
                //判断code等于200且status等于0
                if code != 200 || status != 0 {
                    print("获取成员列表失败")
                    return
                }
                //读取json中的data字段值字典
                let dataDic = json["data"].dictionaryValue
                //读取datadic中的activateRelative数组
                let activateRelativeArray = dataDic["activateRelative"]?.arrayValue
                //把activateRelative数组中的每个字典转换为Member结构体并赋值给members数组
                self.members = activateRelativeArray?.map { Member(relativeHead: $0["relativeHead"].stringValue, relativeRel: $0["relativeRel"].stringValue, relativeName: $0["relativeName"].stringValue) } ?? []
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
