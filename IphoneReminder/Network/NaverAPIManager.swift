//
//  NaverAPIManager.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

final class NaverAPIManager {
    static let shared = NaverAPIManager()
    private init() { }
    
    func fetchData<T: Decodable>(type: T.Type, api: NaverAPI, completionHandler: @escaping (T?, NetworkError?) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, .failedRequest)
                fatalError("네트워킹 오류")
            }
        }
        
    }
}
