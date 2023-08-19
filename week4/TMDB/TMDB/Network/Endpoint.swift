//
//  Endpoint.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/14.
//

import Foundation

enum Endpoint {
    
    case trending
    case credit(type: MediaType, id: Int)
    case genre
    case recommend(type: MediaType, id: Int)
    case detail(type: MediaType, id: Int)
    
    var requestURL: String {
        switch self {
        case .trending: return URL.makeEndPointString("trending/all/day?")
        case .credit(let type, let movieID): return URL.makeEndPointString("\(type.rawValue)/\(movieID)/credits?")
        case .genre: return URL.makeEndPointString("genre/movie/list?")
        case .recommend(let type, let id): return URL.makeEndPointString("\(type.rawValue)/\(id)/recommendations?")
        case .detail(let type, let id): return URL.makeEndPointString("\(type.rawValue)/\(id)?")
        }
    }
    
}
