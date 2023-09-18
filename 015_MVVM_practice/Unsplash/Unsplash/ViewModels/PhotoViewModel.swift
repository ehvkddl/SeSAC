//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

class PhotoViewModel {
    
    var photo = Observable(Photo(total: 0, total_pages: 0, results: []))
    var photoList = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    var itemCount: Int {
        return photoList.value.results.count
    }
    
    func fetchPhoto(of query: String) {
        UnsplashAPIManager.shared.fetchPhotos(of: query) { photoList in
            self.photoList.value = photoList
            self.photo.value = photo
        }
    }
    
    func reset() {
        self.photoList.value = Photo(total: 0, total_pages: 0, results: [])
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> PhotoResult {
        return self.photoList.value.results[indexPath.item]
    }
    
}
