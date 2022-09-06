//  Created by Filip Kjamilov on 5.9.22.

import Foundation
import SwiftUI

class APODViewModel: ObservableObject {
    
    @Published var data: [APODData] = []
    
    func fetchData(startDate: Date = Date.now, endDate: Date = Date.now) {
        // TODO: FKJ - Not readable refactor!
        let url = "https://api.nasa.gov/planetary/apod?api_key=mj7IKILdJygMqg3HYTVvQJl0sO870jpCLA6Yv7ch&start_date=\(convertDateToString(date: startDate))&end_date=\(convertDateToString(date: endDate))"
        guard let url = URL(string: url) else {
            // TODO: FKJ - Handle error or throw
            return
        }
        
        print("URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([APODData].self, from: data)
                    DispatchQueue.main.async {
//                        self.data.append(contentsOf: decodedData)
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
    
    
    private func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: date)!)
    }
}
