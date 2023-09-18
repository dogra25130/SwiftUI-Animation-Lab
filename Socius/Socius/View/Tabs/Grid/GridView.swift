//
//  GridView.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//

import SwiftUI
import Photos

struct GridView: View {
    @ObservedObject var photoLibraryObserver = PhotoObserver()
    @ObservedObject var orientationObserver = OrientationObserver()
    @State private var deviceOrientation = UIDeviceOrientation.portrait
    @State private var isImageDetailViewPresented: Bool = false
    @State private var selectedImage: UIImage = UIImage()
    @State private var permissionDenied: Bool = false
    
    var isPortrait: Bool {
        return deviceOrientation == .portrait || deviceOrientation == .portraitUpsideDown
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(.vertical) {
                    let size = geometry.size.width / (isPortrait ? 3 : 5)
                    let columnsPortrait = Array(repeating: GridItem(.fixed(size), spacing: 0), count: 3)
                    let columnsLandscape = Array(repeating: GridItem(.fixed(size), spacing: 0), count: 5)
                    LazyVGrid(columns: (isPortrait ? columnsPortrait : columnsLandscape), spacing: .zero) {
                        ForEach(photoLibraryObserver.photos, id: \.localIdentifier) { asset in
                            PhotoCell(asset: asset, size: size)
                                .onTapGesture {
                                    PhotoCell.loadThumbnail(asset: asset, size: .zero) { image in
                                        selectedImage = image
                                        withAnimation {
                                            isImageDetailViewPresented = true
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            if isImageDetailViewPresented {
                Color.black
                VStack {
                    Spacer()
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .transition(.opacity)
                        .cornerRadius(12)
                        .onTapGesture {
                            isImageDetailViewPresented = false
                        }
                    Spacer()
                }
                .padding()
                .shadow(color: .white, radius: 12)
            }
        }
        .onReceive(orientationObserver.$deviceOrientation, perform: { newOrientation in
            if newOrientation.isPortrait || newOrientation.isLandscape {
                deviceOrientation = newOrientation
            }
        })
        .alert(isPresented: $permissionDenied) {
            Alert(
                title: Text("Photos Permission Required"),
                message: Text("Please enable photo permissions in settings."),
                primaryButton: .default(Text("Settings"), action: {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }),
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { permission in
                switch permission {
                case .denied, .notDetermined:
                    permissionDenied = true
                default:
                    permissionDenied = false
                }
            }
        }
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
