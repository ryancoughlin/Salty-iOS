import SwiftUI

struct ContentView: View {
    let dummyData: Station? = Station.loadDummyData()
    let firstTide: Station.Tide?
    
    init() {
        if let station = dummyData, let tide = station.tides.first?.value.first {
            firstTide = tide
        } else {
            firstTide = nil
        }
    }
    
    var body: some View {
        VStack {
            if let tide = firstTide {
                TideView(tide: tide)
            } else {
                Text("Error loading tide data")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
    }
}

struct TideView: View {
    let tide: Station.Tide
    
    var body: some View {
        VStack {
            Text(tide.type.rawValue)
                .font(.largeTitle)
                .bold()
            
            Text(tide.time, style: .time)
                .font(.title2)
            
            Text("Height: \(tide.height, specifier: "%.2f") meters")
                .font(.title3)
                .padding(.top)
        }
        .padding()
    }
}

// Add the following struct for the PreviewProvider support
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
