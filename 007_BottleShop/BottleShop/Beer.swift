//
//  Beer.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import Foundation

struct Beer: Codable {
    var name: String
    var tagline: String
    var description: String
    var imageURL: String
    var abv: Double
    var ibu: Double?
    var srm: Double?
    var foodPairing: [String]
    var brewersTips: String
    
    enum CodingKeys: String, CodingKey {
        case name, tagline
        case description
        case imageURL = "image_url"
        case abv, ibu
        case srm
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}
