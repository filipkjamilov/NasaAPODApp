//  Created by Filip Kjamilov on 5.9.22.

import SwiftUI

@main
struct NasaAPODAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DashboardView()
                    .navigationBarTitle("Astronomy pictures", displayMode: .automatic)
            }
        }
    }
}
