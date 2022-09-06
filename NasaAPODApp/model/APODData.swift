//  Created by Filip Kjamilov on 5.9.22.

import Foundation

struct APODData: Decodable, Hashable {
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}
