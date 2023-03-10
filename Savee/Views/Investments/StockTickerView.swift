//
//  StockTickerView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI
import XCAStocksAPI

struct StockTickerView: View {
    
    @StateObject var chartVM: ChartViewModel
    @StateObject var quoteVM: TickerQuoteViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView.padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
                .padding(.horizontal)
            scrollView
        }
        .padding(.top)
        .background(Color(uiColor: .systemBackground))
        .task(id: chartVM.selectedRange.rawValue) {
            if quoteVM.quote == nil {
                await quoteVM.fetchQuote()
            }
            await chartVM.fetchData()
        }
    }
    
    private var scrollView: some View {
        ScrollView {
            priceDiffRowView
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.horizontal)
            
            Divider()
            
            ZStack {
                DateRangePickerView(selectedRange: $chartVM.selectedRange)
                    .opacity(chartVM.selectedXOpacity)
                
                Text(chartVM.selectedXDateText)
                    .font(.headline)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
            }
            
            
            Divider().opacity(chartVM.selectedXOpacity)
            
            chartView
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 220)
            
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var chartView: some View {
        switch chartVM.fetchPhase {
        case .fetching: LoadingStateView()
        case .success(let data):
            ChartView(data: data, vm: chartVM)
        case .failure(let error):
            ErrorStateView(error: "Chart: \(error.localizedDescription)")
        default: EmptyView()
        }
    }
    
    private var priceDiffRowView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let quote = quoteVM.quote {
                HStack {
                    if quote.isTrading,
                       let price = quote.regularPriceText,
                       let diff = quote.regularDiffText {
                        priceDiffStackView(price: price, diff: diff, caption: nil)
                    } else {
                        if let atCloseText = quote.regularPriceText,
                           let atCloseDiffText = quote.regularDiffText {
                            priceDiffStackView(price: atCloseText, diff: atCloseDiffText, caption: "At Close")
                        }
                        
                        if let afterHourText = quote.postPriceText,
                           let afterHourDiffText = quote.postPriceDiffText {
                            priceDiffStackView(price: afterHourText, diff: afterHourDiffText, caption: "After Hours")
                        }
                    }
                    
                    Spacer()
                }
            }
            exchangeCurrencyView
        }
    }
    
    private var exchangeCurrencyView: some View {
        HStack(spacing: 4) {
            if let exchange = quoteVM.ticker.exchDisp {
                Text(exchange)
            }
            
            if let currency = quoteVM.quote?.currency {
                Text("??")
                Text(currency)
            }
        }
        .font(.subheadline.weight(.semibold))
        .foregroundColor(Color(uiColor: .secondaryLabel))
    }
    
    private func priceDiffStackView(price: String, diff: String, caption: String?) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline, spacing: 16) {
                Text(price).font(.headline.bold())
                Text("\(diff)%").font(.subheadline.weight(.semibold))
                    .foregroundColor(diff.hasPrefix("-") ? .red : .green)
            }
            
            if let caption {
                Text(caption)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(quoteVM.ticker.symbol).font(.title.bold())
            if let shortName = quoteVM.ticker.shortname {
                Text(shortName)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            closeButton
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(.plain)
    }
}
