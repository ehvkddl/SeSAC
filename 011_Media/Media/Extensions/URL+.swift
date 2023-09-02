//
//  URL+.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import Foundation

extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageURL = "https://image.tmdb.org/t/p/w500/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
    
}
