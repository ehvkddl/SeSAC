//
//  CinemaAPIManager.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/24.
//

import Foundation
import CoreLocation
import Alamofire

class CinemaAPImanager {
    
    static let shared = CinemaAPImanager()
    private init() {}
    
    let headers: HTTPHeaders = [
        "Authorization": "KakaoAK \(APIKey.kakaoKey)"
    ]
    
    func fetchLocations(
        around location: CLLocationCoordinate2D,
        successCompletionHandler: @escaping ([Cinema]) -> (),
        failureCompletionHandler: @escaping () -> ()
    ) {
        let parameters: Parameters = [
            "x": location.longitude,
            "y": location.latitude,
            "radius": 5000
        ]
        
        let url = Endpoint.Search.Keyword.cinema.requestURL
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate()
            .responseDecodable(of: LocationData.self) { response in
                switch response.result {
                case .success(let value):
                    
                    successCompletionHandler(value.documents)
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    failureCompletionHandler()
                    
                }
            }
    }
    
}
