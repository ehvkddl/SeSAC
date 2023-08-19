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
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmFhNTI3ZWZkYjIwZWI5OTlkY2VjMWJmYWE4NWM5NiIsInN1YiI6IjY0ZDEzNzBkZDhkMzI5MDExZTc0YmE0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b02Ozt3Zntfjrhbw1uoEN-VJtaSF9zPxTkAG9gBIV78"
    ]
    
    let language = URLQueryItem(name: "language", value: "en")
    let apiKey = URLQueryItem(name: "api_key", value: "\(APIKey.tmdbKey)")
    
    func fetchTrend(completionHandler: @escaping (TreandResponse) -> Void) {
        var components = URLComponents(string: Endpoint.trending.requestURL)
        components?.queryItems = [language, apiKey]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: TreandResponse.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value)
                
            case .failure(let error):
                print("ERROR", error)
            }
        }
    }
    
    func fetchCredit(type: MediaType, id: Int, completionHandler: @escaping (Credit) -> Void) {
        var components = URLComponents(string: Endpoint.credit(type: type, id: id).requestURL)
        components?.queryItems = [language, apiKey]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                    
                completionHandler(value)
                
            case .failure(let error):
                print("ERROR", error)
            }
        }
    }
    
    func fetchGenres(completionHandler: @escaping ([Genre]) -> Void) {
        var components = URLComponents(string: Endpoint.genre.requestURL)
        components?.queryItems = [language, apiKey]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                    
                completionHandler(value.genres)
                    
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRecommendations(type: MediaType, id: Int) {
        var components = URLComponents(string: Endpoint.recommend(type: type, id: id).requestURL)
        components?.queryItems = [language, apiKey]

        guard let url = components?.string else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: RecommendData.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
