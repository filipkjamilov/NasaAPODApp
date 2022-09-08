//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

@main
struct NasaAPODAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    DashboardView()
                        .navigationBarTitle("Astronomy pictures", displayMode: .automatic)
                }.background {
                    Image("background")
                        .resizable()
                        .opacity(0.25)
                        .ignoresSafeArea()
                }
                
            }
        }
    }
}
