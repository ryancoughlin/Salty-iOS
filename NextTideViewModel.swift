import Foundation
import SwiftUI

class NextTideViewModel: ObservableObject {
    @Published private(set) var nextTide: Station.Tide?
    @Published private(set) var remainingTime: TimeInterval = 0
    
    private var station: Station
    private let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter
    }()
    
    init(station: Station) {
        self.station = station
        calculateNextTideAndRemainingTime()
    }
    
    private func calculateNextTideAndRemainingTime() {
        guard let todayTides = station.todayTides else {
            return
        }
        
        let currentTime = Date()
        let futureTides = todayTides.filter { $0.time > currentTime }
        
        if let nextTide = futureTides.min(by: { $0.time < $1.time }) {
            self.nextTide = nextTide
            self.remainingTime = nextTide.time.timeIntervalSince(currentTime)
        } else {
            self.nextTide = nil
            self.remainingTime = 0
        }
    }
    
    var nextTideType: Station.Tide.TideType? {
        nextTide?.type
    }
    
    var formattedRemainingTime: String {
        return timeFormatter.string(from: remainingTime) ?? "N/A"
    }
}
