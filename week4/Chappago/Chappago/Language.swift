//
//  Language.swift
//  Chappago
//
//  Created by do hee kim on 2023/08/10.
//

import Foundation

enum Language: String, CaseIterable {
    case detect = "dt"
    case ko, en, ja
    case zhCN = "zh-CN"
    case zhTW = "zh-TW"
    case vi, id, th, de, ru, es, it, fr
    
    var code: String {
        return self.rawValue
    }
    
    var text: String {
        switch self {
        case .detect: return "언어감지"
        case .ko: return "한국어"
        case .en: return "영어"
        case .ja: return "일본어"
        case .zhCN: return "중국어 간체"
        case .zhTW: return "중국어 번체"
        case .vi: return "베트남어"
        case .id: return "인도네시아어"
        case .th: return "태국어"
        case .de: return "독일어"
        case .ru: return "러시아어"
        case .es: return "스페인어"
        case .it: return "이탈리아어"
        case .fr: return "프랑스어"
        }
    }
    
    var target: [Language] {
        switch self {
        case .detect: return []
        case .ko: return [.en, .ja, .zhCN, .zhTW, .vi, .id, .th, .de, .ru, .es, .it, .fr]
        case .en: return [.ko, .ja, .fr, .zhCN, .zhTW]
        case .ja: return [.ko, .en, .zhCN, .zhTW]
        case .zhCN: return [.ko, .en, .ja, .zhTW]
        case .zhTW: return [.ko, .en, .ja, .zhCN]
        case .fr: return [.ko, .en]
        default: return [.ko]
        }
    }
    
}
