//
//  MainListView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI
import XCAStocksAPI

struct InvestmentView: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @StateObject var searchVM = SearchViewModel()
    
    var body: some View {
        tickerListView
            .listStyle(.plain)
            .overlay { overlayView }
            .navigationTitle(Text("Investments"))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchVM.query)
            .refreshable { await quotesVM.fetchQuotes(tickers: appVM.tickers) }
            .sheet(item: $appVM.selectedTicker) {
                StockTickerView(chartVM: ChartViewModel(ticker: $0, apiService: quotesVM.stocksAPI), quoteVM: .init(ticker: $0, stocksAPI: quotesVM.stocksAPI))
                    .presentationDetents([.height(430)])
            }
            .task(id: appVM.tickers) { await quotesVM.fetchQuotes(tickers: appVM.tickers) }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerCardListView(
                    data: .init(
                        symbol: ticker.symbol,
                        name: ticker.shortname,
                        price: quotesVM.priceForTicker(ticker),
                        type: .main))
                .contentShape(Rectangle())
                .onTapGesture {
                    appVM.selectedTicker = ticker
                }
                .listRowSeparator(.hidden)
            }
            .onDelete { appVM.removeTickers(atOffsets: $0) }
            .listRowSeparator(.hidden)
        }
        .opacity(searchVM.isSearching ? 0 : 1)
    }
    
    @ViewBuilder
    private var overlayView: some View {
        if appVM.tickers.isEmpty {
            EmptyStateView(text: "Search & add symbol to see stock quotes")
        }
        
        if searchVM.isSearching {
            SearchView(searchVM: searchVM)
        }
    }
}
