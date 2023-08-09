//
//  ViewController.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/09.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(query: "스위프트")
    }

    func callRequest(query: String) {
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let document = try JSONDecoder().decode(Document.self, from: data)

                    self.books = document.documents
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
