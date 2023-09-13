//
//  LottoAPIManager.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

class LottoAPIManager {
    
    static let shared = LottoAPIManager()
    private init() { }
    
    func fetchLotto(round drwNo: Int, completionHandler: @escaping (Lotto) -> Void) {
        guard let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)") else {
            print("URL 변환 실패")
            return
        }
        
        fetchData(from: url) { (lotto: Lotto) in
            completionHandler(lotto)
        }

    }
    
    private func fetchData<T: Codable>(from url: URL, completionHandler: @escaping (T) -> Void) {
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("request를 실패했습니다.", error)
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
                
                completionHandler(result)
                
            } catch {
                print("decoding을 실패했습니다.")
            }
        }.resume()
        
    }
    
}
