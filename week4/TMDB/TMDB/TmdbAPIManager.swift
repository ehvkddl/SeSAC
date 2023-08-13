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
    
    func fetchCredit(movieID: Int, completionHandler: @escaping (Credit) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits?language=en-US&api_key=\(APIKey.tmdbKey)"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmFhNTI3ZWZkYjIwZWI5OTlkY2VjMWJmYWE4NWM5NiIsInN1YiI6IjY0ZDEzNzBkZDhkMzI5MDExZTc0YmE0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b02Ozt3Zntfjrhbw1uoEN-VJtaSF9zPxTkAG9gBIV78"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(Credit.self, from: data)
                    
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
