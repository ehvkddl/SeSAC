//
//  URL+.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/24.
//

import Foundation

extension URL {
    
    static let baseURL = "https://dapi.kakao.com/v2/local/"
    
    static func makeEndpointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
    
}
