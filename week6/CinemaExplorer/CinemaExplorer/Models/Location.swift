//
//  Location.swift
//  CinemaExplorer
//
//  Created by do hee kim on 2023/08/24.
//

import Foundation

enum CinemaType: String, CaseIterable {
    case mega = "메가박스"
    case lotte = "롯데시네마"
    case cgv = "CGV"
    case other = "기타"
}

// MARK: - LocationData
struct LocationData: Codable {
    let documents: [Cinema]
    let meta: Meta
}

// MARK: - Document
struct Cinema: Codable {
    let addressName: String
    let categoryGroupCode: String?
    let categoryGroupName: String?
    let categoryName, distance, id, phone: String
    let placeName: String
    let placeURL: String
    let roadAddressName, x, y: String
    var type: CinemaType {
        switch placeName.components(separatedBy: " ").first {
        case CinemaType.mega.rawValue: return .mega
        case CinemaType.lotte.rawValue: return .lotte
        case CinemaType.cgv.rawValue: return .cgv
        default: return .other
        }
    }

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        addressName = try container.decode(String.self, forKey: .addressName)
        categoryGroupCode = try container.decode(String.self, forKey: .categoryGroupCode)
        categoryGroupName = try container.decode(String.self, forKey: .categoryGroupName)
        categoryName = try container.decode(String.self, forKey: .categoryName)
        distance = try container.decode(String.self, forKey: .distance)
        id = try container.decode(String.self, forKey: .id)
        phone = try container.decode(String.self, forKey: .phone)
        placeName = try container.decode(String.self, forKey: .placeName)
        placeURL = try container.decode(String.self, forKey: .placeURL)
        roadAddressName = try container.decode(String.self, forKey: .roadAddressName)
        x = try container.decode(String.self, forKey: .x)
        y = try container.decode(String.self, forKey: .y)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(addressName, forKey: .addressName)
        try container.encode(categoryGroupCode, forKey: .categoryGroupCode)
        try container.encode(categoryGroupName, forKey: .categoryGroupName)
        try container.encode(categoryName, forKey: .categoryName)
        try container.encode(distance, forKey: .distance)
        try container.encode(id, forKey: .id)
        try container.encode(phone, forKey: .phone)
        try container.encode(placeName, forKey: .placeName)
        try container.encode(placeURL, forKey: .placeURL)
        try container.encode(roadAddressName, forKey: .roadAddressName)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let sameName: SameName
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case sameName = "same_name"
        case totalCount = "total_count"
    }
}

// MARK: - SameName
struct SameName: Codable {
    let keyword: String
    let region: [String]
    let selectedRegion: String

    enum CodingKeys: String, CodingKey {
        case keyword, region
        case selectedRegion = "selected_region"
    }
}
