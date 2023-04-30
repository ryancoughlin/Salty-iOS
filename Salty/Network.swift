import Foundation

func fetchStationData() async throws -> Station {
    let saltyAPI = "https://salty-server-naxbe.ondigitalocean.app/api/tide-table?latitude=43.0881&longitude=-70.7361"

    guard let url = URL(string: saltyAPI) else { fatalError("Missing URL") }
    let urlRequest = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)

    return try decoder.decode(Station.self, from: data)
}
