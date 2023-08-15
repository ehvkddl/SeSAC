//
//  Endpoint.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/14.
//

import Foundation

enum Endpoint {
    
    case trending
    case movie(movieID: Int)
    case genre
    
    var requestURL: String {
        switch self {
        case .trending: return URL.makeEndPointString("trending/all/day?")
        case .movie(let movieID): return URL.makeEndPointString("movie/\(movieID)/credits?")
        case .genre: return URL.makeEndPointString("genre/movie/list?")
        }
    }
    
}
