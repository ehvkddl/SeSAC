//
//  ToDoInformation.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

struct ToDoInformation {
    
    // 타입 메서드는 인스턴스 생성과 상관 없이 사용 가능!
    static func randomBackgroundColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    var list = [ToDo(main: "잠자기", sub: "23.07.08", like: false, done: true, color: randomBackgroundColor()),
                ToDo(main: "영화보기", sub: "23.07.15", like: true, done: false, color: randomBackgroundColor()),
                ToDo(main: "장보기", sub: "23.07.21", like: false, done: false, color: randomBackgroundColor())]
    
}
