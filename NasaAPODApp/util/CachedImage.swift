//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

struct CachedImage<Content: View>: View {
    
    @StateObject private var manager = CachedImageManager()
    let url: String
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    var body: some View {
        ZStack {
            switch manager.imageState {
            case .fetching:
                content(.empty)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                } else {
                    content(.failure(CachedImageError.invalidData))
                }
            case .failed(let error):
                content(.failure(error))
            default:
                content(.empty) 
            }
        }
        .task {
            await manager.load(url)
        }
    }
}

extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}
