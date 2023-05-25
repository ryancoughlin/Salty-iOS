//
//  StationViewTidesChart.swift
//  Salty
//
//  Created by Julian Worden on 5/5/23.
//

import Charts
import SwiftUI

struct StationViewTidesChart: View {
    @ObservedObject var viewModel: StationViewModel

    let geo: GeometryProxy

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                ZStack {
                    // Adds an invisible rectangle to each data point on chart. Allows ScrollViewReader
                    // to move chart to current tide when the chart is presented.
                    HStack {
                        ForEach(viewModel.tides, id: \.self) { tide in
                            Rectangle()
                                .id(tide)
                                .foregroundColor(.clear)
                                .onAppear {
                                    if tide == viewModel.currentTide {
                                        scrollViewProxy.scrollTo(tide, anchor: UnitPoint.center)
                                    }
                                }
                        }
                    }

                    Chart(viewModel.tides, id: \.self) { tide in
                        // Main line in chart
                        LineMark(
                            x: .value("Date and Time", tide.dateStringAsDate),
                            y: .value("Height", tide.heightStringAsDouble)
                        )
                        .foregroundStyle(Color(ColorConstants.lineChartBlue))
                        .interpolationMethod(.cardinal)
                        .lineStyle(StrokeStyle(lineWidth: 3))

                        if viewModel.tideIsLowOrHighTide(tide) {
                            // Calls out high or low tide. Can't add drop shadow unless targeting iOS 16.4+
                            PointMark(
                                x: .value("Date and Time", tide.dateStringAsDate),
                                y: .value("Height", tide.heightStringAsDouble)
                            )
                            .foregroundStyle(Color(ColorConstants.lineChartBlue))
                            .symbolSize(UiConstants.lineChartPrimarySymbolSize)
                            // Up or down arrow of high or low tide, respectively.
                            .annotation(position: .overlay) {
                                if viewModel.tideIsHighTide(tide) {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .foregroundColor(.white)
                                } else if viewModel.tideIsLowTide(tide) {
                                    Image(systemName: "arrow.down")
                                        .imageScale(.small)
                                        .foregroundColor(.white)
                                }
                            }
                            // Time and measurement label for high or low tide.
                            .annotation(position: .top) {
                                VStack {
                                    Text(tide.dateStringAsDate.formatted(date: .omitted, time: .shortened))
                                        .foregroundColor(Color(ColorConstants.lineChartBlue))
                                        .bold()

                                    Text(tide.heightAsFeetMeasurementString)
                                        .font(.caption)
                                }
                            }
                        }

                        if tide == viewModel.currentTide {
                            // Calls out current tide.
                            PointMark(
                                x: .value("Date and Time", tide.dateStringAsDate),
                                y: .value("Height", tide.heightStringAsDouble)
                            )
                            .foregroundStyle(Color(ColorConstants.lineChartYellow))
                            .symbolSize(UiConstants.lineChartSecondarySymbolSize)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [0, 2, 4, 6, 8, 10]) {
                            AxisValueLabel(format: .feet)
                            #warning("Add .font(_:) modifier to AxisValueLabel to edit Y Axis font")
                            AxisGridLine(centered: nil, stroke: StrokeStyle(dash: [15]))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .hour, count: 2)) {
                            AxisValueLabel()
                            #warning("Add .font(_:) modifier to AxisValueLabel to edit X Axis font")
                        }
                    }
                }
                .frame(width: geo.size.width * 2, height: 178)
                .padding()
            }
        }
    }
}

struct StationViewTidesChart_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            StationViewTidesChart(viewModel: StationViewModel(), geo: geo)
        }
    }
}
