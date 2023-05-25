import Foundation

@MainActor
final class StationViewModel: ObservableObject {
    @Published private(set) var station: Station? = Station.loadDummyData()
    /// All of today's tides separated by 30-minute intervals.
    @Published private(set) var tides = [Tide]()

    /// The first 24 tides in the `tides` array.
    var tidesFirstTwelveHours: [Tide] {
        return Array(tides.prefix(through: 23))
    }

    /// The last 24 tides in the `tides` array.
    var tidesLastTwelveHours: [Tide] {
        return Array(tides.suffix(from: 24))
    }

    /// The tide with the highest height measurement in the `tidesFirstTwelveHours` array.
    var highTideFirstTwelveHours: Tide {
        return tidesFirstTwelveHours.max { lhs, rhs in
            lhs.heightStringAsDouble < rhs.heightStringAsDouble
        }!
    }

    /// The tide with the lowest height measurement in the `tidesFirstTwelveHours` array.
    var lowTideFirstTwelveHours: Tide {
        return tidesFirstTwelveHours.min { lhs, rhs in
            lhs.heightStringAsDouble < rhs.heightStringAsDouble
        }!
    }

    /// The tide with the highest height measurement in the `tidesLastTwelveHours` array.
    var highTideLastTwelveHours: Tide {
        return tidesLastTwelveHours.max { lhs, rhs in
            lhs.heightStringAsDouble < rhs.heightStringAsDouble
        }!
    }

    /// The tide with the lowest height measurement in the `tidesLastTwelveHours` array.
    var lowTideLastTwelveHours: Tide {
        return tidesLastTwelveHours.min { lhs, rhs in
            lhs.heightStringAsDouble < rhs.heightStringAsDouble
        }!
    }

    /// Finds the current tide in the `tides` array by comparing the current hour against the hour of each tide in the array.
    var currentTide: Tide? {
        var currentTide: Tide?
        let currentHour = Calendar.current.dateComponents([.hour], from: Date.now)
        for tide in tides {
            let tideHour = Calendar.current.dateComponents([.hour], from: tide.dateStringAsDate)

            if currentHour == tideHour {
                currentTide = tide
            }
        }

        return currentTide
    }

    /// Determines whether or not a given tide is a high or low tide in the `tides` array. Useful
    /// for identifying when a tide should be labeled as high or low in `StationViewTideChart`.
    /// - Parameter tide: The tide in question.
    /// - Returns: Whether or not the tide is a high or low tide.
    func tideIsLowOrHighTide(_ tide: Tide) -> Bool {
        return tide == highTideFirstTwelveHours ||
               tide == lowTideFirstTwelveHours ||
               tide == highTideLastTwelveHours ||
               tide == lowTideLastTwelveHours
    }

    /// Determines whether or not a given tide is a low tide. Useful for identifying if an up arrow
    /// or down arrow should be shown for a tide in `StationViewTideChart`.
    /// - Parameter tide: The tide in question.
    /// - Returns: Whether or not the tide is a low tide.
    func tideIsLowTide(_ tide: Tide) -> Bool {
        return tide == lowTideFirstTwelveHours ||
               tide == lowTideLastTwelveHours
    }

    /// Determines whether or not a given tide is a high tide. Useful for identifying if an up arrow
    /// or down arrow should be shown for a tide in `StationViewTideChart`.
    /// - Parameter tide: The tide in question.
    /// - Returns: Whether or not the tide is a high tide.
    func tideIsHighTide(_ tide: Tide) -> Bool {
        return tide == highTideLastTwelveHours ||
               tide == highTideFirstTwelveHours
    }

    func getStationData() async {
        do {
            self.station = try await fetchStationData()
        } catch {
            print(error)
        }
    }

    /// Fetches today's tides.
    func getTidesData() async {
        do {
            tides = try await fetchTideDataFromApi()
        } catch {
            print(error)
        }
    }

    func getHighLowData() async {
        do {
            try await fetchHighLowDataFromApi()
        } catch {
            print(error)
        }
    }
    
    var nextTide: Station.Tide? {
        guard let todayTides = station?.todayTides else {
            return nil
        }
        
        let currentTime = Date()
        let nextTide = todayTides.first { $0.time > currentTime }
        
        print(nextTide!)
        
        return nextTide
    }

    var timeRemainingUntilNextTide: String {
        guard let todayTides = station?.todayTides else {
            return "N/A"
        }
        
        let currentTime = Date()
        let nextTide = todayTides.first { $0.time > currentTime }
        
        guard let tide = nextTide else {
            return "N/A"
        }
        
        let timeInterval = tide.time.timeIntervalSince(currentTime)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: timeInterval) ?? "N/A"
    }
}
