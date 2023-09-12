//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

class PhotoViewModel {
    
    var photo = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    var itemCount: Int {
        return photo.value.results.count
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> PhotoResult {
        return self.photo.value.results[indexPath.item]
    }
    
}
