//
//  URL+.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

extension URL {
    
    static let unsplashBaseURL = "https://api.unsplash.com/"
    
    static func makeEndpointString(_ endpoint: String) -> String {
        return unsplashBaseURL + endpoint
    }
    
}
