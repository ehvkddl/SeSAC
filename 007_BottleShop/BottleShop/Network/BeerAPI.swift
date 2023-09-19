//
//  BeerAPI.swift
//  BottleShop
//
//  Created by do hee kim on 2023/09/20.
//

import Foundation
import Alamofire

enum BeerAPI {
    
    case beers(filterType: BeersFilter?, value: String?)
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/"
    }
    
    var endpoint: URL {
        switch self {
        case .beers: return URL(string: baseURL + "beers")!
        case .singleBeer: return URL(string: baseURL + "beers/1")!
        case .randomBeer: return URL(string: baseURL + "beers/random")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .beers, .singleBeer, .randomBeer: return .get
        }
    }
    
    var query: [String: String] {
        switch self {
        case .beers(let filterType, let value):
            guard let type = filterType, let value = value else {
                return [:]
            }
            return [type.rawValue: value]
        case .singleBeer, .randomBeer:
            return [:]
        }
    }
    
}

enum BeersFilter: String {
    case abv_gt
    case abv_lt
    case ibu_gt
    case ibu_lt
    case ebc_gt
    case ebc_lt
    case beer_name
    case yeast
    case brewed_before
    case brewed_after
    case hops
    case malt
    case food
    case ids
}
