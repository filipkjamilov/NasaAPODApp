//  Created by Filip Kjamilov on 5.9.22.

import Foundation
import SwiftUI

class APODViewModel: ObservableObject {
    
    private var baseUrl: String {
        return "https://api.nasa.gov/planetary/apod"
    }
    
    private var apiKey: String {
        return "mj7IKILdJygMqg3HYTVvQJl0sO870jpCLA6Yv7ch"
    }
    
    private var apiUrl: String {
        return baseUrl + "?api_key=" + apiKey
    }
    
    @Published var data: [APODData] = []
    
    func fetchData(startDate: Date = Date.now, endDate: Date = Date.now) {
                
        let url = "\(apiUrl)&start_date=\(Date.convertDateToString(date: startDate))&end_date=\(Date.convertDateToString(date: endDate))"
        guard let url = URL(string: url) else {
            // TODO: FKJ - Handle error or throw
            return
        }
                
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([APODData].self, from: data)
                    DispatchQueue.main.async {
                        self.data.insert(contentsOf: decodedData, at: 0)
                    }
                } catch {
                    // TODO: FKJ - Handle error or throw
                    print("Wrong!")
                    print(error)
                }
            }
            
        }.resume()
    }
    
}
