//
//  NaverAPI.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation
import Alamofire

enum NaverAPI {
    case image(query: String)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/"
    }
    
    var endpoint: URL {
        switch self {
        case .image:
            return URL(string: baseURL + "search/image")!
        }
    }
    
    var header: HTTPHeaders {
        return ["X-Naver-Client-Id": APIKey.naverClientID,
                "X-Naver-Client-Secret": APIKey.naverClientSecret]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .image(let query):
            ["query": query]
        }
    }
}
