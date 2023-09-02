//
//  UnsplashAPIManager.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import Foundation

class UnsplashAPIManager {
    
    static let shared = UnsplashAPIManager()
    private init() {}
    
    let authorizationHeader = ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
    
    func fetchData<T: Codable>(from url: URL, completionHandler: @escaping (T) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = authorizationHeader
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                print("status code가 200~500을 벗어났습니다.")
                return
            }
            
            guard let data = data else {
                print("data가 비어있습니다.")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                print(result)
                
                completionHandler(result)
                
            } catch {
                print("디코딩 실패")
            }
        }.resume()
        
    }
    
}
