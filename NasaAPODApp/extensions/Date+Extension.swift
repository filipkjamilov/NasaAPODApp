//  Created by Filip Kjamilov on 7.9.22.

import Foundation

public extension Date {
    
    static func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        // TODO: FKJ - Do not minus a day in here, separation of concerns.
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: date)!)
    }
    
}
