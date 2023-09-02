//
//  Similar.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import Foundation

// MARK: - SimilarData
struct SimilarData: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
