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
    
    // TODO: FKJ - Temporary solution to take the picture from the previous day,
    // as the server date and the local date are not the same.
    public var endDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    public var startDate: Date = Calendar.current.date(byAdding: .day, value: -5, to: .now)!
    
    public func fetchOnViewDidLoad() {
        fetchData(from: startDate, to: endDate)
    }
    
    public func loadMore() {
        self.endDate = Calendar.current.date(byAdding: .day, value: -1, to: self.startDate)!
        self.startDate = Calendar.current.date(byAdding: .day, value: -6, to: self.endDate)!
        fetchData(from: startDate, to: endDate)
    }
    
    // MARK: -
    
    private func fetchData(from start: Date = Date.now, to end: Date = Date.now) {
        
        let url = "\(apiUrl)&start_date=\(Date.convertDateToString(date: start))&end_date=\(Date.convertDateToString(date: end))"
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([APODData].self, from: data)
                    DispatchQueue.main.async {
                        self.data.insert(contentsOf: decodedData, at: 0)
                    }
                } catch {
                    self.handleError(with: error)
                }
            }
            
        }.resume()
    }
    
    private func handleError(with error: Error){
        print("Error occurred!")
    }
    
}
