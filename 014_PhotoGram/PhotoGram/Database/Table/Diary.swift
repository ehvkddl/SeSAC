//
//  Diary.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/15.
//

import Foundation
import RealmSwift

class Diary: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var content: String?
    @Persisted var photoURL: String?
    
    convenience init(
        title: String,
        date: Date,
        content: String?,
        photoURL: String?
    ) {
        self.init()
        
        self.title = title
        self.date = date
        self.content = content
        self.photoURL = photoURL
    }
    
}
