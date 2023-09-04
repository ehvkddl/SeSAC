//
//  BookTable.swift
//  Bookworm
//
//  Created by do hee kim on 2023/09/04.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var authors: List<String>
    @Persisted var contents: String
    @Persisted var datetime: String
    @Persisted var isbn: String
    @Persisted var price: Int
    @Persisted var publisher: String
    @Persisted var salePrice: Int
    @Persisted var status: String
    @Persisted var thumbnail: String
    @Persisted var title: String
    @Persisted var translators: List<String>
    @Persisted var url: String
    
    convenience init(
        authors: List<String>,
        contents: String,
        datetime: String,
        isbn: String,
        price: Int,
        publisher: String,
        salePrice: Int,
        status: String,
        thumbnail: String,
        title: String,
        translators: List<String>,
        url: String
    ) {
        self.init()
        
        self.authors = authors
        self.contents = contents
        self.datetime = datetime
        self.isbn = isbn
        self.price = price
        self.publisher = publisher
        self.salePrice = salePrice
        self.status = status
        self.thumbnail = thumbnail
        self.title = title
        self.translators = translators
        self.url = url
    }
}
