//
//  Photo.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import Foundation

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable, Hashable {
    let identifier = UUID().uuidString
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable, Hashable {
    let full: String
    let thumb: String
}
