//
//  HomeView.swift
//  InsectIdentifier
//
//  Created by Hussnain on 12/03/2025.
//

import SwiftUI
import Photos



struct GalleryScreen: View {
    @Environment(\.presentationMode) var presentationMode
   
    @StateObject var viewModel = GalleryViewModel()
    var body: some View {
        VStack {
            TopBarView(title: "Gallery", onBack: {
                presentationMode.wrappedValue.dismiss()
            }
            ).padding(.horizontal,15)
            
            ScrollView {
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                               ForEach(viewModel.images) { file in
                                   GalleryItem(fileItem: file)
                               }
                           }
                           .padding()
                       }
          
        }.navigationBarBackButtonHidden().onAppear{
            checkPhotoLibraryPermission { isPermissionAllowed in
                if(isPermissionAllowed){
                    print("Permission allowed")
                    viewModel.fetchImages()
                }else
                {
                    print("Permission not allowed")
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
       
    }
}



struct GalleryItem: View {
    let fileItem: FileItem
    @State private var uiImage: UIImage?

    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            } else {
                ProgressView()
                    .frame(height: 150)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    func loadImage() {
        let asset = PHAsset.fetchAssets(withLocalIdentifiers: [fileItem.id], options: nil).firstObject
        let manager = PHImageManager.default()

        manager.requestImage(for: asset!,
                             targetSize: CGSize(width: 150, height: 150),
                             contentMode: .aspectFill,
                             options: nil) { image, _ in
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}


private func checkPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
    let status = PHPhotoLibrary.authorizationStatus()
    
    switch status {
    case .authorized, .limited:
        completion(true)
    case .denied, .restricted:
        completion(false)
    case .notDetermined:
        PHPhotoLibrary.requestAuthorization { newStatus in
            DispatchQueue.main.async {
                completion(newStatus == .authorized || newStatus == .limited)
            }
        }
    default:
        completion(false)
    }
}
#Preview {
    GalleryScreen()
}
