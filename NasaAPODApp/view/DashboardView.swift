//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var apodData = APODViewModel()
    @State private var endDate: Date = .now
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -5, to: .now)!
    
    var body: some View {
            List(apodData.data.reversed(), id: \.self) { data in
                
                CachedImage(url: data.url) { phase in
                    
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        
                        NavigationLink(destination: DetailsView(apodData: data)) {
                            image
                                .resizable()
                                .scaledToFit()
                                .onAppear(perform: {
                                    // TODO: FKJ - Consider moving this in the viewModel?
                                    if data.date == convertDateToString(date: startDate) {
                                        endDate = Calendar.current.date(byAdding: .day, value: -1, to: startDate)!
                                        startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
                                        apodData.fetchData(startDate: startDate, endDate: endDate)
                                    }
                                })
                        }
                        
                    case .failure(let error):
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                    
                }
            }.viewDidLoad(perform: {
                apodData.fetchData(startDate: startDate, endDate: endDate)
            })
        
    }
    
    private func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}

struct DetailsView: View {
    
    public var apodData: APODData
    
    var body: some View {
        CachedImage(url: apodData.url) { phase in
            
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}
