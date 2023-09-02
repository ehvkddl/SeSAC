//
//  Endpoint.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import Foundation

enum Endpoint {
    enum Search {
        case photos
        
        var requestURL: String {
            switch self {
            case .photos: return URL.makeEndpointString("search/photos?")
            }
        }
    }
}
