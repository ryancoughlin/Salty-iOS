import SwiftUI

struct StationScreen: View {
    @StateObject var viewModel: StationViewModel = StationViewModel()

    var body: some View {
        VStack {
            Text(viewModel.phrase)

            if let station = viewModel.station, let todayTides = station.todayTides {
                List(todayTides) { tide in
                    VStack(alignment: .leading) {
                        Text(tide.type.rawValue)
                        Text("\(tide.height, specifier: "%.1f") ft")
                        Text("\(tide.time, formatter: dateFormatter)")
                    }
                }
            } else {
                Text("No station data")
            }
        }
        .task {
            await viewModel.getStationData()
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

struct StationScreen_Previews: PreviewProvider {
    static var previews: some View {
        StationScreen()
    }
}
