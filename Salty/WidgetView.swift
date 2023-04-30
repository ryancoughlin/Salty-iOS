import SwiftUI

struct WidgetView: View {
    let station: Station
    
    var nextTide: Station.Tide? {
        let now = Date()
        return station.tides.flatMap { $0.value }.sorted { $0.time < $1.time }.first { $0.time > now }
    }
    
    var remainingTime: String {
        if let nextTide = nextTide {
            let remainingTimeInterval = nextTide.time.timeIntervalSinceNow
            let remainingHours = Int(remainingTimeInterval) / 3600
            let remainingMinutes = Int(remainingTimeInterval) % 3600 / 60
            return "\(remainingHours)h \(remainingMinutes)m"
        }
        return "Unknown"
    }
    
    var body: some View {
        VStack {
            Text("Next Tide:")
            if let nextTide = nextTide {
                let tideType = nextTide.type
                let tideDirection = tideType == .high ? "Outgoing" : "Incoming"
                Text("\(tideType.rawValue.capitalized) at \(nextTide.time.description) (\(tideDirection))")
                Text("Time remaining: \(remainingTime)")
            } else {
                Text("No tide information available")
            }
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(station: Station.loadDummyData()!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
