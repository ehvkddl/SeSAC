//
//  Genres.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/12.
//

import Foundation

// MARK: - Welcome
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
