//
//  DiaryRepository.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/15.
//

import Foundation
import RealmSwift

class DiaryRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ item: Diary) {
        do {
            try realm.write {
                realm.add(item)
                print("일기 저장 성공!")
                print(realm.objects(Diary.self))
            }
        } catch {
            print("일기 저장 실패!", error)
        }
    }
    
}
