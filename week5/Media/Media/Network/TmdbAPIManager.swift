//
//  TmdbAPIManager.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
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
    
    let language = URLQueryItem(name: "language", value: "ko-KR")
    let apiKey = URLQueryItem(name: "api_key", value: "\(APIKey.tmdbKey)")
    
    // MARK: - fetchSearch
    func fetchSearch(title query: String, completionHandler: @escaping ([Movie]) -> Void) {
        let movieTitle = URLQueryItem(name: "query", value: query)
        
        var components = URLComponents(string: EndPoint.search.requestURL)
        components?.queryItems = [language, apiKey, movieTitle]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: SearchData.self) { response in
                switch response.result {
                case .success(let value):
                    
                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - fetchVideo
    func fetchVideo(id: Int, completionHandler: @escaping ([Video]) -> Void) {
        var components = URLComponents(string: EndPoint.video(id: id).requestURL)
        components?.queryItems = [language, apiKey]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: VideoData.self) { response in
                switch response.result {
                case .success(let value):
                    
                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - fetchSimilar
    func fetchSimilar(id: Int, completionHandler: @escaping ([Movie]) -> Void) {
        var components = URLComponents(string: EndPoint.similar(id: id).requestURL)
        components?.queryItems = [language, apiKey]
        
        guard let url = components?.string else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: SimilarData.self) { response in
                switch response.result {
                case .success(let value):
                    
                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
