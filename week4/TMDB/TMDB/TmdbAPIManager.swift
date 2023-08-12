//
//  TmdbAPIManager.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/11.
//

import Foundation
import Alamofire

class TmdbAPIManager {
    static let shared = TmdbAPIManager()
    private init() {}
    
    func fetchTrend(completionHandler: @escaping (TreandResponse) -> Void) {
        let url = "https://api.themoviedb.org/3/trending/all/day?language=en-US&api_key=\(APIKey.tmdbKey)"
        let headers: HTTPHeaders = [
            "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(TreandResponse.self, from: data)
                    
                    completionHandler(decodedData)
                } catch {
                    print("[decode fail]", error.localizedDescription)
                }
            case .failure(let error):
                print("ERROR", error)
            }
        }
    }
    
}
