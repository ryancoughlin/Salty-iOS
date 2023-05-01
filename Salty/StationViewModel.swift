import Foundation

class StationViewModel: ObservableObject {
    @Published private(set) var station: Station? = Station.loadDummyData()

    func getStationData() async {
        do {
            self.station = try await fetchStationData()
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
