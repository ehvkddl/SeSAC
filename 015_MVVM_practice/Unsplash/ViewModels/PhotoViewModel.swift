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
    
    func fetchPhoto(of query: String) {
        UnsplashAPIManager.shared.fetchPhotos(of: query) { photo in
            self.photo.value = photo
        }
    }
    
    func reset() {
        self.photo.value = Photo(total: 0, total_pages: 0, results: [])
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> PhotoResult {
        return self.photo.value.results[indexPath.item]
    }
    
}
