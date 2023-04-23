//
//  String+Extension.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 23/4/23.
//

import Foundation

extension String {
    var double: Double {
        Double(self) ?? .zero
    }
    
    func stringToDate() -> String {
        let date: Date = Date(timeIntervalSince1970: self.double)
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
