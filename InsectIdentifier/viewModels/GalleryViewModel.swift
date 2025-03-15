//
//  GalleryViewModel.swift
//  InsectIdentifier
//
//  Created by Hussnain on 15/03/2025.
//

import SwiftUI
import Combine
import Photos


class ImageRepository {
    func fetchImages() -> Future<[FileItem], Never> {
        return Future { promise in
            var fetchedImages: [FileItem] = []
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            fetchResult.enumerateObjects { asset, _, _ in
                let id = asset.localIdentifier
                let title = asset.value(forKey: "filename") as? String ?? "Unknown"

                let fileItem = FileItem(id: id, title: title, path: id)
                fetchedImages.append(fileItem)
            }

            DispatchQueue.main.async {
                promise(.success(fetchedImages))
            }
        }
    }
}

class GalleryViewModel: ObservableObject {
    @Published var images: [FileItem] = []
    private var cancellables = Set<AnyCancellable>()
    private let repository = ImageRepository()

    func fetchImages() {
        repository.fetchImages()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                self?.images = images
            }
            .store(in: &cancellables)
    }
}
