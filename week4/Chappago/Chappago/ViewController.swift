//
//  ViewController.swift
//  Chappago
//
//  Created by do hee kim on 2023/08/10.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
    }

    func callRequest() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.Naver.ClientID,
            "X-Naver-Client-Secret": APIKey.Naver.ClientSecret
        ]
        let parameter: Parameters = [
            "source": "ko",
            "target": "en",
            "text": "태풍이 와요"
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(Translator.self, from: data)
                    
                    print(decodedData)
                } catch {
                    print(error.localizedDescription, "ㅠㅠ")
                }
            case .failure(let error):
                print("ERROR!", error)
            }
        }
        
    }
    
}

