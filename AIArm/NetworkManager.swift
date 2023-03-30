import Moya
import SwiftyJSON

let provider = MoyaProvider<API>()

enum API {
    case login(username: String, password: String)
    case getUserInfo(userId: Int)
    case getFamilyMembers(groupId: Int)
    case addPatientInfo(name: String, idCardNumber: String, relation: String, illnessDesc: String, avatarUrl: String, isDefault: Bool, hospitalId: Int)
}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: "http://10.11.3.234:8088/api/v1.0/armband_dev/")!
    }

    var path: String {
        switch self {
        case .login:
            return "armband/user/login/password"
        case .getUserInfo(let userId):
            return "/user/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(userId)"
        case .getFamilyMembers(let groupId):
            return "/family/group/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(groupId)/members"
        case .addPatientInfo:
            return "/patient/info"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getUserInfo:
            return .get
        case .getFamilyMembers:
            return .get
        case .addPatientInfo:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestData(bodyData(
                ["phone":username,
                 "password":password
                ]))
        case .getUserInfo:
            return .requestPlain
        case .getFamilyMembers(let groupId):
            return .requestParameters(parameters: ["groupid": groupId], encoding: URLEncoding.default)
        case .addPatientInfo(let name, let idCardNumber, let relation, let illnessDesc, let avatarUrl, let isDefault, let hospitalId):
            return .requestParameters(parameters: ["name": name, "id_card_number": idCardNumber, "relation": relation, "illness_desc": illnessDesc, "avatar_url": avatarUrl, "is_default": isDefault, "hospital_id": hospitalId], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    private func bodyData(_ bodyDict : [String : Any]) -> Data {
        let bodyData = try! JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted)
        return bodyData
    }
}

//provider.request(.addPatientInfo(name: "张三", idCardNumber: "123456789012345678", relation: "父亲", illnessDesc: "感冒", avatarUrl: "<http://example.com/avatar.jpg>", isDefault: true, hospitalId: 123)) { result in
//    switch result {
//    case let .success(response):
//        let data = response.data
//        let json = JSON(data)
//        // 解析json数据
//    case let .failure(error):
//        print(error)
//    }
//}


