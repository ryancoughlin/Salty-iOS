import SwiftUI

struct NextTideWrapperView: View {
    @State private var station: Station? = Station.loadDummyData()
    
    var body: some View {
        VStack {
            if let station = station {
                NextTideView(viewModel: NextTideViewModel(station: station))
            } else {
                Text("Loading station data...")
            }
        }
        .padding()
    }
}

struct NextTideWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        NextTideWrapperView()
    }
}
