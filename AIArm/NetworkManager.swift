//
//  NetworkManager.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

import Moya
import SwiftyJSON

let provider = MoyaProvider<API>()

enum API {
    case login(username: String, password: String)
    case getUserInfo(userId: Int)
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
            return "/user/\\(userId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getUserInfo:
            return .get
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

//provider.request(.login(username: "yourusername", password: "yourpassword")) { result in
//    switch result {
//    case let .success(response):
//        let data = response.data
//        let json = JSON(data)
//        // 解析json数据
//    case let .failure(error):
//        print(error)
//    }
//}

