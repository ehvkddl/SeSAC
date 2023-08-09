//
//  Extension+Array.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/10.
//

import Foundation

extension Array {
    
    func terminator() -> String {
        var str = ""
        
        for (idx, content) in self.enumerated() {
            str.append("\(content)")
            if idx < self.count - 1 {
                str.append(", ")
            }
        }
        
        return str
    }
    
}
