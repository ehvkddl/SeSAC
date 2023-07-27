//
//  Setting.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/27.
//

import Foundation

enum Setting: String, CaseIterable {
    case all = "전체 설정"
    case personal = "개인 설정"
    case etc = "기타"
    
    var text: String { rawValue }
    
    enum All: String, CaseIterable {
        case notice = "공지사항"
        case lab = "실험실"
        case version = "버전 정보"
        
        var text: String { rawValue }
    }
    
    enum Peronal: String {
        case personalSecurity = "개인/보안"
        case notification = "알림"
        case chatting = "채팅"
        case multiprofile = "멀티프로필"
        
        var text: String { rawValue }
    }
    
    enum Etc: String {
        case help = "고객센터/도움말"
        
        var text: String { rawValue }
    }
}
