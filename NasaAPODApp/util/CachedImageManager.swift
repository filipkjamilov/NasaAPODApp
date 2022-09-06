//  Created by Filip Kjamilov on 5.9.22.

import Foundation

final class CachedImageManager: ObservableObject {
    
    @Published private(set) var imageState: ImageState?
    
    private let imageLoader = ImageLoader()
    
    @MainActor
    func load(_ imageURL: String,
              cache: ImageCache = .shared) async {
        
        self.imageState = .fetching
        
        // Check if image exists in cache
        if let imageData = cache.object(forKey: imageURL as NSString) {
            self.imageState = .success(data: imageData)
            return
        }
        
        do {
            let data = try await imageLoader.fetch(imageURL)
            self.imageState = .success(data: data)
            cache.set(object: data as NSData, forKey: imageURL as NSString)
        } catch {
            self.imageState = .failed(error: error)
        }
    }
    
}

extension CachedImageManager {
    enum ImageState {
        case fetching
        case failed(error: Error)
        case success(data: Data)
    }
}
