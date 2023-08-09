//
//  Book.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/09.
//

import Foundation

struct Document: Codable {
    var documents: [Book]
    var meta: Meta
}

struct Book: Codable {
    var authors: [String]
    var contents: String
    var datetime: String
    var isbn: String
    var price: Int
    var publisher: String
    var salePrice: Int
    var status: String
    var thumbnail: String
    var title: String
    var translators: [String]
    var url: String
    
    var info: String {
        var authorStr = ""
        
        for (idx, author) in authors.enumerated() {
            authorStr.append("\(author)")
            if idx < authors.count - 1 {
                authorStr.append(", ")
            }
        }
        return "\(authorStr) 저 | \(publisher)"
    }
    
    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

struct Meta: Codable {
    var isEnd: Bool
    var pageableCount: Int
    var totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}


