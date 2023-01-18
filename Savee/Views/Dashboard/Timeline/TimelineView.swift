//
//  TimeLineView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift
import SwiftUIPager

struct TimelineView: View {
    let maxPages = 4
    @Environment(\.realm) var realm
    
    @ObservedResults(Transaction.self) var transactions
    
    @State var date: Date = Date.now
    
    @ObservedResults(
        Transaction.self,
        filter: NSPredicate(format: "transactionType == 'expense'")
    ) var expenseCategories
    
    @ObservedResults(
        Transaction.self,
        filter: NSPredicate(format: "transactionType == 'income'")
    ) var incomeCategories
    
    @ObservedResults(
        Transaction.self,
        filter: NSPredicate(format: "transactionType == 'investment'")
    ) var investmentCategories
    
    @State var shouldShowSheet: Bool = false
    @State private var swipeDirection: SwipeDirection? = nil
    
    @StateObject var page: Page = .first()
    @State var currentPosition: Int = 0
    
    var body: some View {
        let items = Array(0..<maxPages)
        
        NavigationView {
            ZStack {
                VStack {
                    Pager(page: page, data: items, id: \.self) { item in
                        VStack {
                            PieChartView(
                                values: [
                                    expenseCategories.sum(ofProperty: "amount"),
                                    incomeCategories.sum(ofProperty: "amount"),
                                    investmentCategories.sum(ofProperty: "amount"),
                                ],
                                names: ["Expenses", "Incomes", "Investments"],
                                formatter: {value in String(format: "%.0f CZK", value)},
                                backgroundColor: Color.white,
                                widthFraction: 0.3,
                                innerRadiusFraction: 0.0
                            )
                            
                            if (transactions
                                .sorted(by: >)
                                .filter{ $0.date.get(.year, .month) == date.get(.year, .month) }
                                .count != 0
                            ) {
                                List {
                                    Section("") {
                                        ForEach(transactions
                                            .sorted(by: >)
                                            .filter{ $0.date.get(.year, .month) == date.get(.year, .month) }
                                        ) { transaction in
                                            TransactionRow(
                                                transaction: transaction,
                                                shouldShowSheet: shouldShowSheet
                                            )
                                        }
                                        .onDelete(perform: $transactions.remove)
                                    }
                                }
                                .listStyle(.plain)
                            }
                            else {
                                Spacer()
                                VStack(alignment: .center) {
                                    Image("empty_placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    Text("No transaction yet")
                                        .headerCenter()
                                }
                                .frame(height: 500)
                            }
                        }
                    }
                    .onPageChanged({ newIndex in
                        handleSwipe(newIndex: newIndex)
                    })
                    .contentLoadingPolicy(.eager)
                    .pagingPriority(.simultaneous)
                    .delaysTouches(true)
                    .interactive(scale: 0.95)
                    .horizontal(.endToStart)
                }
                
                newTransactionButton
            }
            .navigationTitle(Text("\(date.formatted(.dateTime.month().year()).capitalizingFirstLetter())"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder var newTransactionButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    openNewTransactionForm()
                } label: {
                    Text("+")
                        .font(.system(.largeTitle))
                        .frame(width: 57, height: 50)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                }
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3
                )
            }
        }
        .sheet(isPresented: $shouldShowSheet) {
          NewTransactionView(transaction: Transaction())
        }
    }
}

extension TimelineView {
    func transfortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+1")
        dateFormatter.dateFormat = "MM-yyyy"
        return "\(date.formatted(.dateTime.month().year()))"
    }
    
    func handleSwipe(newIndex: Int) {
        if currentPosition >= 0 && currentPosition < maxPages {
            if newIndex < currentPosition && currentPosition >= 1 {
                date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
                currentPosition = currentPosition-1
            } else if newIndex > currentPosition && currentPosition < maxPages-1 {
                date = Calendar.current.date(byAdding: .month, value: -1, to: date)!
                currentPosition = currentPosition+1
            }
        }
    }
    
    func openNewTransactionForm() {
        shouldShowSheet.toggle()
    }
}
