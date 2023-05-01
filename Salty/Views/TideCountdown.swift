import SwiftUI

struct TideCountdown: View {
    let formattedTime: String
    let tideType: Station.Tide.TideType

    var body: some View {
        HStack {
            Text("\(formattedTime)")
                .font(.system(size: 18, design: .monospaced))
                .fontWeight(.medium)
                .foregroundColor(.black)

            Text("UNTIL \(tideType.rawValue)")
                .font(.system(size: 18, design: .monospaced))
                .fontWeight(.medium)
        }
    }
}
