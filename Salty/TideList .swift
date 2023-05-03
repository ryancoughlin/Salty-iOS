import SwiftUI

struct TideList: View {
    let dateString: String
    let tides: [Station.Tide]
    let dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(dateString)
                .font(.title)
                .foregroundColor(.blue)
                .padding(.vertical)
            ForEach(tides) { tide in
                VStack(alignment: .leading) {
                    Text(tide.type.rawValue)
                    Text("\(tide.height, specifier: "%.1f") ft")
                    Text("\(tide.time, formatter: dateFormatter)")
                }
                .padding()
            }
        }
    }
}

