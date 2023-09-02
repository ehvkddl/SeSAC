//
//  Intro.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/27.
//

import Foundation

struct Intro {
    let animationName: String
    let title: String
    let subTitle: String
}

extension Intro {
    static let list = [
        Intro(animationName: "popular", title: "시청할 영상을 찾고계신가요?", subTitle: "요즘 인기있는 영화와 TV 프로그램 정보를 알려드릴게요!"),
        Intro(animationName: "movie", title: "MOVIE", subTitle: "이 영화에 누가 나왔는지 캐스팅 목록을 보여드릴게요!"),
        Intro(animationName: "tv", title: "TV", subTitle: "TV 프로그램의 기본 정보부터 시즌, 에피소드 정보까지 알려드릴게요!"),
        Intro(animationName: "watchTV", title: "마음에 드는 컨텐츠를 찾길 바라요!", subTitle: "")
    ]
}
