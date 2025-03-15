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
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var viewModel = GalleryViewModel()
    @State private var isThreadScreen: Bool = false
    @State private var selectedItem: FileItem?=nil
    var body: some View {
        VStack {
            TopBarView(title: "Gallery", onBack: {
                presentationMode.wrappedValue.dismiss()
            }
            ).padding(.horizontal,15)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.images) { file in
                        GalleryItem(fileItem: file,onItemClick: {
                            selectedItem = file
                            isThreadScreen=true
                        })
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }
            
        }.navigationBarBackButtonHidden().navigationDestination(isPresented: $isThreadScreen, destination: {
            if(isThreadScreen ){
                ThreadScreen(fileItem:selectedItem)
            }
        }).onAppear{
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
    let onItemClick:() -> Void
    var body: some View {
        VStack {
            if let uiImage = uiImage {
              
                Button(action: onItemClick) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame( maxHeight: 180)
                        .frame(width: UIScreen.main.bounds.width / 2 - 20)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                        .clipped()
                }
               
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
