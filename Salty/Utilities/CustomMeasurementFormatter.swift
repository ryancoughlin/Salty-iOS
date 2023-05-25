//
//  CustomMeasurementFormatter.swift
//  Salty
//
//  Created by Julian Worden on 5/5/23.
//

import Foundation

struct CustomMeasurementFormatter {
    /// Returns a string representation of a feet measurement. Uses the `.naturalScale` `.unitStyle` option on `MeasurementFormatter`
    /// to automatically show inches value when a measurement has a very low feet value.
    /// - Parameter feetMeasurement: The measurement value that's being converted into a string.
    /// - Returns: A string representation of the value passed into `feetMeasurement`.
    static func getFlexibleFeetString(_ feetMeasurement: Measurement<UnitLength>) -> String {
        let measurementFormatter = MeasurementFormatter()
        let numberFormatter = NumberFormatter()
        // 3 because inches measurement can be negative, and -0" looks strange on chart
        numberFormatter.maximumFractionDigits = 3
        measurementFormatter.unitOptions = .naturalScale
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter = numberFormatter
        return measurementFormatter.string(from: feetMeasurement)
    }

    /// Returns a string representation of a feet measurement. Uses the `.providedUnit` `.unitStyle` option on `MeasurementFormatter`
    /// to strictly only show a feet value, even when the provided measurement has a low feet value.
    /// - Parameter feetMeasurement: The measurement value that's being converted into a string.
    /// - Returns: A string representation of the value passed into `feetMeasurement`.
    static func getExactFeetString(_ feetMeasurement: Measurement<UnitLength>) -> String {
        let measurementFormatter = MeasurementFormatter()
        let numberFormatter = NumberFormatter()
        // 3 because inches measurement can be negative, and -0" looks strange on chart
        numberFormatter.maximumFractionDigits = 3
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter = numberFormatter
        return measurementFormatter.string(from: feetMeasurement)
    }
}
