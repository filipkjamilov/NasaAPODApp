//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

struct ContentView: View {
    
    @StateObject private var apodData = APODViewModel()
    @State private var endDate: Date = .now
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -5, to: .now)!
    
    
    var body: some View {
        List(apodData.data.reversed(), id: \.self) { data in
            
//            Text("StartDate: \(convertDateToString(date: startDate))")
//            Text("EMD: \(convertDateToString(date: endDate))")
            
            CachedImage(url: data.url) { phase in

                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .onAppear(perform: {
                            if data.date == convertDateToString(date: startDate) {
                                endDate = Calendar.current.date(byAdding: .day, value: -1, to: startDate)!
                                startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
                                apodData.fetchData(startDate: startDate, endDate: endDate)
                                
                                print("Fetching data for!!!")
                                print("Start date: \(startDate)")
                                print("END date: \(endDate)")
                            }
                        })
                case .failure(let error):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }

            }
        }.onAppear(perform: {
            apodData.fetchData(startDate: startDate, endDate: endDate)
        })
        
    }
    
    private func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}
