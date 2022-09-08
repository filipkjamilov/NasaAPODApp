//  Created by Filip Kjamilov on 7.9.22.

import Foundation

public extension Date {
    
    static func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}
