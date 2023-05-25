import Foundation
import SwiftPlus

func fetchStationData() async throws -> Station {
    let saltyAPI = "https://salty-server-naxbe.ondigitalocean.app/api/tide-table?latitude=43.0881&longitude=-70.7361"

    guard let url = URL(string: saltyAPI) else { fatalError("Missing URL") }
    let urlRequest = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

    print("STATION DATA: \(data.prettyPrintedJSONString())")

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)

    return try decoder.decode(Station.self, from: data)
}

/// Fetches 24 hour's worth of tide data from NOAA with a 30 minute interval between each tide.
/// - Returns: Today's tides, starting today at midnight through tonight at 11:30 PM.
func fetchTideDataFromApi() async throws -> [Tide] {
    let noaaApiUrlAsString = "https://api.tidesandcurrents.noaa.gov:443/api/prod/datagetter?station=8419870&date=today&range=24&product=predictions&interval=30&datum=mllw&units=english&time_zone=gmt&application=web_services&format=json"

    guard let url = URL(string: noaaApiUrlAsString) else { fatalError("Missing URL") }
    let urlRequest = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

    print(data.prettyPrintedJSONString())

    if let tideResponse = try? JSONDecoder().decode(TideResponse.self, from: data) {
        return tideResponse.predictions
    } else {
        return []
    }
}

func fetchHighLowDataFromApi() async throws {
    let noaaApiUrlAsString = "https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?begin_date=20180509&end_date=20190509&station=9468333&product=high_low&datum=STND&time_zone=gmt&units=english&format=json"

    guard let url = URL(string: noaaApiUrlAsString) else { fatalError("Missing URL") }
    let urlRequest = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

    print(data.prettyPrintedJSONString())
}
