//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var apodData = APODViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack {
                HStack {
                    Text("Limit: \(apodData.limit)/\(apodData.remainingLimit) per hour")
                        .font(.footnote)
                        .padding(.leading, 20)
                    Spacer()
                }
                Divider()
                ForEach(apodData.data.filter({ $0.media_type == "image" }).reversed(), id: \.self) { data in
                    
                    CachedImage(url: data.url) { state in
                        
                        switch state {
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
                                            if data.date == Date.convertDateToString(date: apodData.startDate) {
                                                apodData.loadMore()
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
                apodData.fetchOnViewDidLoad()
            })
        })
    }
    
}
