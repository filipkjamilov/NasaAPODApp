//  Created by Filip Kjamilov on 5.9.22.

import Foundation
import SwiftUI

struct ImageLoader {
    
    func fetch(_ imageURL: String) async throws -> Data {
        guard let imageURL = URL(string: imageURL) else {
            throw ImageLoadingError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        return data
    }
    
}

private extension ImageLoader {
    enum ImageLoadingError: Error {
        case invalidURL
    }
}
