//  Created by Filip Kjamilov on 7.9.22.

import SwiftUI

struct DetailsView: View {
    
    public var apodData: APODData
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    
                    DetailsWidgetGradient()
                    
                    VStack(alignment: .center) {
                        CachedImage(url: apodData.url) { state in
                            switch state {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(30)
                                    .padding(.all, 7)
                            case .failure(_):
                                EmptyView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        DetailsViewDivider()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(apodData.title)
                                .font(.title)
                                .foregroundColor(.primary)
                                .bold()
                            Text("Date taken: \(apodData.date)")
                                .font(.body)
                                .foregroundColor(.primary)
                                .bold()
                            Text(apodData.explanation)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding(.all, 15)
                        
                    }
                }
            }
            .padding(.top, 0)
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .background {
            Image("background")
                .resizable()
                .opacity(0.25)
                .ignoresSafeArea()
        }
        
    }
}

struct DetailsWidgetGradient: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)],
                                 startPoint: .topLeading,
                                 endPoint: .bottomTrailing))
            .shadow(color: Color.secondary, radius: 25, x: -10, y: 10)
    }
}

struct DetailsViewDivider: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .overlay(.black)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .cornerRadius(30)
    }
}

struct DetailsView_Preview: PreviewProvider {
    static var previews: some View {
        DetailsView(apodData: APODData(date: "2022-05-05",
                                       explanation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et lectus purus. Sed venenatis varius ante vel ullamcorper. In tellus augue, varius at euismod et, bibendum ac leo. Mauris efficitur elementum felis, quis convallis lectus. Aliquam erat volutpat. Aenean scelerisque finibus sapien sed congue. Aliquam placerat leo molestie metus convallis posuere. Vivamus egestas pulvinar nisl, eu posuere magna aliquam ut.",
                                       hdurl: "https://image_hd.com",
                                       media_type: "image",
                                       service_version: "v1",
                                       title: "Wonderfull earth",
                                       url: "https://miro.medium.com/max/900/1*jZYv1C8xSOCcJuTEqnbtHQ.jpeg"))
    }
}
