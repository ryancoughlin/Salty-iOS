//
//  Tide.swift
//  Salty
//
//  Created by Julian Worden on 5/4/23.
//

import Foundation

struct Tide: Codable, Hashable {
    let date: String
    let height: String

    enum CodingKeys: String, CodingKey {
        case date = "t"
        case height = "v"
    }

    var dateStringAsDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: date)!
    }

    var heightStringAsDouble: Double {
        return Double(height)!
    }

    var heightAsFeetMeasurementString: String {
        let feetMeasurement = Measurement(value: Double(height)!, unit: UnitLength.feet)
        return CustomMeasurementFormatter.getFlexibleFeetString(feetMeasurement)
    }
}
