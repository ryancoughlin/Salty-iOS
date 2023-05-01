import UIKit
import SwiftCharts

struct TideChart: UIViewRepresentable {

    let tideData: [Double]
    let dates: [String]

    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        chartView.noDataText = "No data available"
        chartView.legend.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.leftAxis.axisMinimum = 0
        return chartView
    }

    func updateUIView(_ chartView: LineChartView, context: Context) {
        // Create an array of chart data entries
        var chartDataEntries = [ChartDataEntry]()
        for i in 0..<tideData.count {
            let chartDataEntry = ChartDataEntry(x: Double(i), y: tideData[i])
            chartDataEntries.append(chartDataEntry)
        }

        // Set the chart data
        let chartDataSet = LineChartDataSet(entries: chartDataEntries, label: nil)
        chartDataSet.setColor(.blue)
        chartDataSet.lineWidth = 2
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.drawValuesEnabled = false
        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData

        // Set the x-axis labels
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
    }
}
