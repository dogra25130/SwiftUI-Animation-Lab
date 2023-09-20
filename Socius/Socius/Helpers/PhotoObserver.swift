//
//  PhotoObserver.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//
import Foundation
import Photos

class PhotoObserver: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    @Published var photos: [PHAsset] = []
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
        fetchPhotos()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        DispatchQueue.main.async {
            self.photos = result.objects(at: IndexSet(0..<result.count))
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        fetchPhotos()
    }
}
