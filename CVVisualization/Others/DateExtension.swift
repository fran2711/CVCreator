//
//  DateExtension.swift
//  CVVisualization
//
//  Created by Fran Lucena on 26/6/18.
//  Copyright © 2018 Fran Lucena. All rights reserved.
//

import Foundation

extension Date {
    func getLongDate() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "es_ES") as Locale
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self).uppercased()
    }
}
