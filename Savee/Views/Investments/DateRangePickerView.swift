//
//  DateRangePickerView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI
import XCAStocksAPI

struct DateRangePickerView: View {
    let rangeTypes = ChartRange.allCases
    @Binding var selectedRange: ChartRange
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(self.rangeTypes) { dateRange in
                    Button {
                        self.selectedRange = dateRange
                    } label: {
                        Text(dateRange.title)
                            .font(.callout.bold())
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .background {
                        if dateRange == selectedRange {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.4))
                        }
                    }
                }
            }.padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}
