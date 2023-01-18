//
//  SearchView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI
import XCAStocksAPI

struct SearchView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @ObservedObject var searchVM: SearchViewModel
    
    var body: some View {
        List(searchVM.tickers) { ticker in
            TickerListView(
                data: .init(
                    symbol: ticker.symbol,
                    name: ticker.shortname,
                    price: quotesVM.priceForTicker(ticker),
                    type: .search(
                        isSaved: appVM.isAddedToMyTickers(ticker: ticker),
                        onButtonTapped: {
                            Task { @MainActor in
                                appVM.toggleTicker(ticker)
                            }
                        }
                    )
                )
            )
            .contentShape(Rectangle())
            .onTapGesture {
                Task { @MainActor in
                    appVM.selectedTicker = ticker
                }
            }
        }
        .listStyle(.plain)
        .refreshable { await quotesVM.fetchQuotes(tickers: searchVM.tickers) }
        .task(id: searchVM.tickers) { await quotesVM.fetchQuotes(tickers: searchVM.tickers) }
        .overlay { listSearchOverlay }
    }
    
    @ViewBuilder
    private var listSearchOverlay: some View {
        switch searchVM.phase {
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) {
                Task { await searchVM.searchTickers() }
            }
        case .empty:
            EmptyStateView(text: searchVM.emptyListText)
        case .fetching:
            LoadingStateView()
        default: EmptyView()
        }
    }
}


