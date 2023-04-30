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
    
    var phrase: String {
        let nextTideType = self.station?.nextTide.type

        if nextTideType == Station.Tide.TideType.high {
            return "Incoming"
        } else {
            return "Outgoing"
        }
    }
}
