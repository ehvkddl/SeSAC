//
//  EndPoint.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import Foundation

enum EndPoint {
    case search
    case video(id: Int)
    case similar(id: Int)
    
    var requestURL: String {
        switch self {
        case .search: return URL.makeEndPointString("search/movie")
        case .video(let id): return URL.makeEndPointString("movie/\(id)/videos")
        case .similar(let id): return URL.makeEndPointString("movie/\(id)/similar")
        }
    }
    
}
