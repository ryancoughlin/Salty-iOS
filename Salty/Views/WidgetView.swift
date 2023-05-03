import SwiftUI

struct WidgetView: View {
    let station: Station
    
    var timeRemaining: String {
        guard let todayTides = station.todayTides else {
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
    
    var body: some View {
        VStack {
            Text("Current Tide")
                .font(.title2)
                .bold()
            
            if let todayTides = station.todayTides, let nextTide = todayTides.first {
                Text("\(nextTide.type.rawValue.capitalized) Tide")
                    .font(.title)
                    .bold()
                
                Text("Height: \(nextTide.height, specifier: "%.2f")")
                    .font(.body)
                
                Text("Time Remaining: \(timeRemaining)")
                    .font(.caption)
            } else {
                Text("No tide data available")
            }
        }
        .padding()
    }
}
