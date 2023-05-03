import SwiftUI

struct TideDirection: View {
    let tideType: Station.Tide.TideType
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Text(tideType == .high ? "Incoming tide" : "Outgoing tide")
                    .font(.system(size: 36, weight: .bold))
                    .tracking(0.5)
                Text(tideType == .high ? "⬆️" : "⬇️")
                    .font(.system(size: 28, weight: .heavy))
                    .tracking(0.5)
            }
        }
    }
}
