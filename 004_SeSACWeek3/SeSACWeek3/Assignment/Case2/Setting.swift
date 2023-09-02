//
//  Setting.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/27.
//

import Foundation

enum Setting: Int, CaseIterable {
    case all = 0
    case personal = 1
    case etc = 2
    
    var text: String {
        switch self {
        case .all: return "전체 설정"
        case .personal: return "개인 설정"
        case .etc: return "기타"
            
        }
    }
    
    var setting: [String] {
        switch self {
        case .all:
            return All.allCases.map { $0.text }
        case .personal:
            return Personal.allCases.map { $0.text }
        case .etc:
            return Etc.allCases.map { $0.text }
        }
    }
    
    enum All: String, CaseIterable {
        case notice = "공지사항"
        case lab = "실험실"
        case version = "버전 정보"
        
        var text: String { rawValue }
    }
    
    enum Personal: String, CaseIterable {
        case personalSecurity = "개인/보안"
        case notification = "알림"
        case chatting = "채팅"
        case multiprofile = "멀티프로필"
        
        var text: String { rawValue }
    }
    
    enum Etc: String, CaseIterable {
        case help = "고객센터/도움말"
        
        var text: String { rawValue }
    }
}
