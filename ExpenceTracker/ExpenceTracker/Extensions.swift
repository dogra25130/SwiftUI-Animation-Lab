//
//  Extensions.swift
//  ExpenceTracker
//
//  Created by Abhishek Dogra on 03/09/23.
//

import SwiftUI
extension Color {
    static let backgound = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    static let longTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd’T’HH:mm:ssZ"
        return formatter
    }()
    
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedDate
    }
}

extension Date {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
    
    func usaFormatted() -> String {
        return DateFormatter.allNumericUSA.string(from: self)
    }
    
    func longFormatted() -> String {
        return DateFormatter.longTime.string(from: self)
    }
}

extension Double {
    func roundedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
