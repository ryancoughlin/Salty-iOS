//import SwiftUI
//import SwiftUICharts
//
//struct TideChartView: View {
//    let tideData: [TideData]
//    let currentTime: Date
//    
//    var body: some View {
//        LineChartView(data: tideData.map { $0.v },
//                      title: "Tide",
//                      legend: "ft",
//                      style: Styles.lineChartStyleOne,
//                      form: ChartForm.extraLarge,
//                      dropShadow: false,
//                      valueSpecifier: "%.2f")
//            .marker(chartData: [currentTime.timeIntervalSince1970: (tideData.last?.v ?? 0)],
//                    type: .vertical,
//                    color: Color.red,
//                    alignment: .center)
//    }
//}
//
//struct TideData: Codable {
//    let t: Date
//    let v: Double
//}
//
//class TideAPI {
//    static let shared = TideAPI()
//    
//    func fetchTideData(completion: @escaping ([TideData]) -> Void) {
//        let url = URL(string: "https://tidesandcurrents.noaa.gov/api/datagetter?product=predictions&application=NOS.COOPS.TAC.WL&begin_date=\(Date().dateString(format: "yyyyMMdd"))&end_date=\((Date() + 7.days).dateString(format: "yyyyMMdd"))&datum=MLLW&station=8419870&time_zone=lst_ldt&units=english&interval=hilo&format=json")!
//        
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let data = data else { return }
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//            
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
//            
//            let decodedData = try! decoder.decode(TideAPIResponse.self, from: data)
//            
//            completion(decodedData.data)
//        }.resume()
//    }
//}
//
//struct TideAPIResponse: Codable {
//    let metadata: TideMetadata
//    let data: [TideData]
//}
//
//struct TideMetadata: Codable {
//    let id: String
//    let name: String
//    let lat: String
//    let lon: String
//}
//
//extension Date {
//    func dateString(format: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
//}
//
//extension Int {
//    var days: TimeInterval { TimeInterval(self * 86400) }
//}
