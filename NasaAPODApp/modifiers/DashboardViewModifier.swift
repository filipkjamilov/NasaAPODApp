//  Created by Filip Kjamilov on 6.9.22.

import Foundation
import SwiftUI

struct DashboardViewModifier: ViewModifier {
    
    @State private var didLoad = false
    
    private let action: (() -> Void)?
    
    init(perform action: (() -> Void)?) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !didLoad {
                didLoad = true
                action?()
            }
        }
    }
    
}

extension View {
    
    // Custom modifier for loading the view
    func viewDidLoad(perform action: (() -> Void)?) -> some View {
        modifier(DashboardViewModifier(perform: action))
    }
    
}
