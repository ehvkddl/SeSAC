//
//  Endpoint.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/24.
//

import Foundation

enum Endpoint {
    
    enum Search {
        
        enum Keyword {
            case cinema
            
            var requestURL: String {
                switch self {
                case .cinema:
                    let query = "영화관".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
                    return URL.makeEndpointString("search/keyword?query=\(query)")
                }
            }
        }
        
    }
    
}
