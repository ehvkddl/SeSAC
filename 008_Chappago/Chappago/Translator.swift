//
//  Translator.swift
//  Chappago
//
//  Created by do hee kim on 2023/08/10.
//

import Foundation

struct Translator: Codable {
    let message: Message
}

struct Message: Codable {
    let type, service, version: String
    let result: Result

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case service = "@service"
        case version = "@version"
        case result
    }
}

struct Result: Codable {
    let srcLangType, tarLangType, translatedText: String
}
