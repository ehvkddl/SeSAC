//
//  Network.swift
//  BottleShop
//
//  Created by do hee kim on 2023/09/20.
//

import Foundation
import Alamofire

enum BeerError: Int, Error, LocalizedError {
    case missingParameter = 400 // If a parameter is passed without a value it will return a 400 error.
    
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "필터 값을 입력해주세요"
        }
    }
}

class Network {
    
    static let shared = Network()
    private init() {}
    
    func request<T: Decodable>(type: T.Type, api: BeerAPI, completion: @escaping (Result<T, BeerError>) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = BeerError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
    
}
