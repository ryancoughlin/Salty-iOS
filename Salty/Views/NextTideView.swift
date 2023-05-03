import SwiftUI

struct NextTideView: View {
    @ObservedObject var viewModel: NextTideViewModel
    
    var body: some View {
        VStack() {
            if viewModel.nextTide != nil {
                VStack(alignment: .leading, spacing: 8) {
                    TideDirection(tideType: viewModel.nextTideType ?? .low) // Provide a default value
                    TideCountdown(formattedTime: viewModel.formattedRemainingTime, tideType: viewModel.nextTideType ?? .low)
                }
            } else {
                Text("Loading station data...")
            }
        }
    }
}

struct NextTideView_Previews: PreviewProvider {
    @ViewBuilder
    static var previews: some View {
        if let station = Station.loadDummyData() {
            NextTideView(viewModel: NextTideViewModel(station: station))
        } else {
            Text("Failed to load dummy data")
        }
    }
}

// ... (rest of the code remains the same)

