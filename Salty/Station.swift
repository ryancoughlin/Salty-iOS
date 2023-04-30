import Foundation
import CoreLocation

struct Station: Identifiable, Decodable {
    let id: Int
    let name: String
    let latitude: String
    let longitude: String
    let tides: [String: [Tide]]
    let nextTide: Tide
    
    var location: CLLocation {
        guard let latitude = Double(latitude) else {
            fatalError("Invalid latitude value")
        }
        guard let longitude = Double(longitude) else {
            fatalError("Invalid latitude value")
        }
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var todayTides: [Tide]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todayDateString = dateFormatter.string(from: Date())
        return tides[todayDateString]
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    struct Tide: Identifiable, Decodable {
        var id = UUID()
        let time: Date
        let height: Double
        let type: TideType
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let timeString = try container.decode(String.self, forKey: .time)
            
            if let time = Station.dateFormatter.date(from: timeString) {
                self.time = time
            } else {
                throw DecodingError.dataCorruptedError(forKey: .time, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
            
            height = try container.decode(Double.self, forKey: .height)
            type = try container.decode(TideType.self, forKey: .type)
        }
        
        enum TideType: String, Decodable {
            case high = "high"
            case low = "low"
        }
        
        enum CodingKeys: String, CodingKey {
            case time, height, type
        }
    }
    
    static func loadDummyData() -> Station? {
        guard let url = Bundle.main.url(forResource: "Tides", withExtension: "json") else {
            print("Unable to find Tides.json file")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Self.dateFormatter)
            let station = try decoder.decode(Station.self, from: data)
            return station
        } catch {
            print("Error decoding Tides.json: \(error)")
            return nil
        }
    }
}
