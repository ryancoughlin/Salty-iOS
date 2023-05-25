//
//  FormatStyle+feet.swift
//  Salty
//
//  Created by Julian Worden on 5/5/23.
//

import Foundation

/// Converts a double to a string representation of a feet measurement. Returns an exact feet value instead of a value that
/// automatically scales small feet measurements down to inches.
struct FeetFormatStyle: FormatStyle {
    typealias FormatInput = Double
    typealias FormatOutput = String

    func format(_ value: Double) -> String {
        let feetMeasurement = Measurement(value: value, unit: UnitLength.feet)
        return CustomMeasurementFormatter.getExactFeetString(feetMeasurement)
    }
}

extension FormatStyle where Self == FeetFormatStyle {
    /// Converts a double to a string representation of a feet measurement. Returns an exact feet value instead of a value that
    /// automatically scales small feet measurements down to inches.
    static var feet: FeetFormatStyle { .init() }
}
