import SwiftUI

struct StationScreen: View {
    @StateObject var viewModel = StationViewModel()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            if let station = viewModel.station {
                Text(station.name)
                NextTideWrapperView()
                
                TabView {
                    ForEach(station.tides.keys.sorted(), id: \.self) { dateString in
                        let tidesForDay = station.tides[dateString] ?? []
                        if !tidesForDay.isEmpty {
                            TideList(dateString: dateString, tides: tidesForDay, dateFormatter: dateFormatter)
                        } else {
                            Text("No tide data for this day.")
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .task {
            await viewModel.getStationData()
        }
    }
}
