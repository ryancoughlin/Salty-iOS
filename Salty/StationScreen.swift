import Charts
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
        GeometryReader { geo in
            VStack {
                if let station = viewModel.station {
                    Text(station.name)

                    HStack {
                        NextTideWrapperView()
                        Spacer()
                    }

                    StationViewTidesChart(viewModel: viewModel, geo: geo)
                    
//                    TabView {
//                        ForEach(station.tides.keys.sorted(), id: \.self) { dateString in
//                            let tidesForDay = station.tides[dateString] ?? []
//                            if !tidesForDay.isEmpty {
//                                TideList(dateString: dateString, tides: tidesForDay, dateFormatter: dateFormatter)
//                            } else {
//                                Text("No tide data for this day.")
//                            }
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle())
                }
            }
            .task {
                await viewModel.getStationData()
                await viewModel.getTidesData()
                await viewModel.getHighLowData()
            }
        }
    }
}
