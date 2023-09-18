//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import Foundation

class PhotoViewModel {
    
    var photo: Observable<PhotoResult?> = Observable(nil)
    
    var photoList = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    var itemCount: Int {
        return photoList.value.results.count
    }
    
    func getImageAtPhoto(completion: @escaping (Data?) -> Void) {
        var data = Data()
        
        guard let photo = photo.value else {
            
            completion(nil)
            
            return
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: photo.urls.thumb) else {
                print("url 변환 실패")
                return
            }
            do {
                data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    
                    completion(data)
                    
                }
            } catch {
                print("url을 data로 변환 실패")
            }
        }
        
    }
    
    func fetchPhoto(of query: String) {
        UnsplashAPIManager.shared.fetchPhotos(of: query) { photoList in
            self.photoList.value = photoList
        }
    }
    
    func fetchRandomPhoto() {
        UnsplashAPIManager.shared.fetchRandomPhoto { photo in
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
