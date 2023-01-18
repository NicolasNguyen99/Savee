//
//  TimelineView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift

struct MainDashboardView: View {
    var body: some View {
        MenuView()
    }
}

struct MenuView: View {
    @Environment(\.realm) var realm
    
    enum Tabs: String {
        case TimeLine
        case Investments
        case More
    }
    
    @State private var selectedTab: Tabs = Tabs.TimeLine
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .tabItem { Label("Timeline", systemImage: "chart.bar.xaxis") }
                .tag(Tabs.TimeLine)
            
            //InvestmentsView()
            NavigationStack {
                InvestmentView()
            }
                .tabItem { Label("Investments", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(Tabs.Investments)
            
            MoreView()
                .tabItem { Label("More", systemImage: "ellipsis") }
                .tag(Tabs.More)
        }
        .accentColor(Color("saveeBlue"))
        .navigationBarBackButtonHidden(true)
    }
}

struct MainDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        MainDashboardView()
    }
}
