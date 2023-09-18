//
//  PhotoCell.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//


import Foundation
import SwiftUI
import Photos

struct PhotoCell: View {
    let asset: PHAsset
    let size: CGFloat
    var body: some View {
        let image = PhotoCell.loadThumbnail(asset: asset, size: CGSize(width: size, height: size))
        Image(uiImage: image)
            .resizable()
            .frame(width: size, height: size)
            .clipped()
            .border(Color.black)
        
    }
    
    static func loadThumbnail(asset: PHAsset, size: CGSize) -> UIImage {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.resizeMode = .fast
        var thumbnail: UIImage?
        
        imageManager.requestImage(for: asset,
                                  targetSize: size ==  .zero ? PHImageManagerMaximumSize : size,
                                  contentMode: .aspectFit,
                                  options: requestOptions) { (result, _) in
            thumbnail = result
        }
        
        return thumbnail ?? UIImage()
    }
    
    static func loadThumbnail(asset: PHAsset, size: CGSize, completion: @escaping (UIImage) -> Void) {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat // Use high-quality format
        requestOptions.resizeMode = .exact // Retain the exact size
        requestOptions.isSynchronous = false // Use asynchronous requests

        imageManager.requestImage(for: asset,
                                  targetSize: size == .zero ? PHImageManagerMaximumSize : size,
                                  contentMode: .aspectFit,
                                  options: requestOptions) { (result, _) in
            completion(result ?? UIImage())
        }
    }
}
