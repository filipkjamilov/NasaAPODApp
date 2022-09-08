//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var apodData = APODViewModel()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -5, to: .now)!
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack {
                ForEach(apodData.data.filter({ $0.media_type == "image" }).reversed(), id: \.self) { data in
                    
                    CachedImage(url: data.url) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            
                            ZStack {
                                NavigationLink(destination: DetailsView(apodData: data)) {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(15)
                                        .padding(.all, 3)
                                        .padding(.leading, 7)
                                        .padding(.trailing, 7)
                                        .listRowInsets(.init())
                                        .onAppear(perform: {
                                            // TODO: FKJ - Consider moving this in the viewModel?
                                            if data.date == Date.convertDateToString(date: startDate) {
                                                print("Image shown")
                                                endDate = Calendar.current.date(byAdding: .day, value: -1, to: startDate)!
                                                startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
                                                apodData.fetchData(startDate: startDate, endDate: endDate)
                                            }
                                        })
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text(data.title)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .padding()
                                            .shadow(radius: 5)
                                    }
                                }
                            }
                            
                        case .failure(_):
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                }
            }
            .viewDidLoad(perform: {
                apodData.fetchData(startDate: startDate, endDate: endDate)
            })
        })
        
    }
    
}
