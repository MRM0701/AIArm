import Moya
import SwiftyJSON
import CommonCrypto


let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

enum API {
    case login(username: String, password: String)
    case getUserInfo(userId: Int)
    case getFamilyMembers(groupId: Int)
    case addPatientInfo(name: String, idCardNumber: String, relation: String, illnessDesc: String, avatarUrl: String, isDefault: Bool, hospitalId: String)
    case getGroupMembers(userId: String, groupId: String)
    case getPatientInfoList
    case searchAllArmbandGroup(groupId: String)


}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: "http://172.17.24.197:8088/api/v1.0/armband_dev")!
    }

    var path: String {
        switch self {
        case .login:
            return "/armband/user/login/password"
        case .getUserInfo(let userId):
            return "/user/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(userId)"
        case .getFamilyMembers(let groupId):
            return "/family/group/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(groupId)/members"
        case .addPatientInfo:
            return "/patient/info"
        case .getGroupMembers:
            return "/armband/group/search/all"
        case .getPatientInfoList:
            return "/patient/info"
        case .searchAllArmbandGroup:
            return "/armband/group/search/all"
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
        case .getGroupMembers:
            return .post
        case .getPatientInfoList:
            return .get
        case .searchAllArmbandGroup:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login(let username, let password):
            let md5Password = password.zy_md5String
            return .requestData(bodyData(
                ["phone":username,
                 "password":md5Password
                ]))
        case .getUserInfo:
            return .requestPlain
        case .getFamilyMembers(let groupId):
            return .requestParameters(parameters: ["groupid": groupId], encoding: URLEncoding.default)
        case .addPatientInfo(let name, let idCardNumber, let relation, let illnessDesc, let avatarUrl, let isDefault, let hospitalId):
            return .requestParameters(parameters: ["name": name, "id_card_number": idCardNumber, "relation": relation, "illness_desc": illnessDesc, "avatar_url": avatarUrl, "is_default": isDefault, "hospital_id": hospitalId], encoding: JSONEncoding.default)
        case .getGroupMembers(let userId, let groupId):
            return .requestData(bodyData(
            ["userId":userId,
             "groupId":groupId
            ]))
        case .getPatientInfoList:
            return .requestPlain
        case .searchAllArmbandGroup(let groupId):
            return .requestData(bodyData(
            ["groupId":groupId
            ]))
//            return .requestParameters(parameters: ["groupId": groupId], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        var headers: [String: String] = [:]
        if let token = UserDefaults.standard.string(forKey: "token"), UserDefaults.standard.bool(forKey: "isLogin") {
            headers["Authorization"] = token
        }
        headers["Content-type"] = "application/json"
        return headers
    }



    private func bodyData(_ bodyDict : [String : Any]) -> Data {
        let bodyData = try! JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted)
        return bodyData
    }
    private func md5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let data = string.data(using: String.Encoding.utf8) {
            _ = data.withUnsafeBytes { bytes in
                CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
            }
        }
        return (0..<length).reduce("") { $0 + String(format: "%02x", digest[$1]) }
    }

}

final class NetworkLoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        let body: String
        switch target.task {
        case let .requestParameters(parameters, _):
            body = parameters.map {"\($0.key)=\($0.value)" }.joined(separator: "&")
        case let .requestData(data):
            body = String(data: data, encoding: .utf8) ?? ""
        default:
            body = ""
        }
        print("Request: \(target.baseURL)\(target.path)")
        print("Method: \(target.method.rawValue)")
        print("Body: \(body)")
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            guard let jsonObject = try? response.mapJSON() else {
                print("Response: \(target.baseURL)\(target.path) Error: Can't convert response to JSON object.")
                return
            }
            print("Response: \(target.baseURL)\(target.path)")
            print("Status Code: \(response.statusCode)")
            print("Body: \(jsonObject)")
        case let .failure(error):
            print("Response: \(target.baseURL)\(target.path) Error: \(error.localizedDescription)")
        }
    }
}

extension String {
    /// 原生md5
    public var zy_md5String: String {
        guard let data = data(using: .utf8) else {
            return self
        }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
#if swift(>=5.0)
        
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        
#else
        
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        
#endif
        
        return digest.map { String(format: "%02x", $0) }.joined()
        
    }
    
}
