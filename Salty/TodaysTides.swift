import SwiftUI

struct TideListView: View {
    @State private var station = Station.loadDummyData()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Today's Tides")
                .font(.title)
                .padding(.bottom, 10)

            List {
                ForEach(station?.todayTides ?? [], id: \.time) { tide in
                    TideRow(tide: tide)
                }
            }
        }
        .padding()
    }
}

struct TideRow: View {
    let tide: Station.Tide

    var body: some View {
        HStack {
            Text(tide.type.rawValue)
                .font(.headline)
            Spacer()
            Text("\(tide.height, specifier: "%.1f") ft")
                .font(.subheadline)
            Spacer()
            Text("\(tide.time, formatter: dateFormatter)")
                .font(.subheadline)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}

struct TideListView_Previews: PreviewProvider {
    static var previews: some View {
        TideListView()
    }
}
