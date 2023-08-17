//
//  Recommend.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/18.
//

import Foundation

// MARK: - RecommendData
struct RecommendData: Codable {
    let page: Int
    let results: [VideoInfo]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

