//
//  GridView.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var photoLibraryObserver = PhotoObserver()
    @ObservedObject var orientationObserver = OrientationObserver()
    @State private var deviceOrientation = UIDeviceOrientation.portrait
    @State private var isImageDetailViewPresented: Bool = false
    @State private var selectedImage: UIImage = UIImage()
    
    var isPortrait: Bool {
        return deviceOrientation == .portrait || deviceOrientation == .portraitUpsideDown
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    let size = geometry.size.width / (isPortrait ? 3 : 5)
                    let columnsPortrait = Array(repeating: GridItem(.fixed(size), spacing: 0), count: 3)
                    let columnsLandscape = Array(repeating: GridItem(.fixed(size), spacing: 0), count: 5)
                    LazyVGrid(columns: (isPortrait ? columnsPortrait : columnsLandscape), spacing: .zero) {
                        ForEach(photoLibraryObserver.photos, id: \.localIdentifier) { asset in
                            PhotoCell(asset: asset, size: size)
                                .onTapGesture {
                                    selectedImage = PhotoCell.loadThumbnail(asset: asset, size: .zero)
                                    isImageDetailViewPresented = true
                                }
                        }
                    }
                }
            }
            .navigationBarTitle("Photos", displayMode: .automatic) // Set the title here
        }
        .onReceive(orientationObserver.$deviceOrientation, perform: { newOrientation in
            if newOrientation.isPortrait || newOrientation.isLandscape {
                deviceOrientation = newOrientation
            }
        })
        .sheet(isPresented: $isImageDetailViewPresented) {
//            ImageDetailView(image: $selectedImage)
        }
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}


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
}
