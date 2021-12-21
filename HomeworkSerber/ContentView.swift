//
//  ContentView.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var incomeData: IncomeData
    
    var body: some View {
        TabView(selection: $router.selection) {
            TextScreen()
                .tabItem {
                    Text("Text")
                    Image(systemName: "menucard")
                }
                .tag(0)
            ResultsScreen()
                .tabItem {
                    Text("Results")
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
        }
        
        .onOpenURL { url in
            if url == URL(string: "homework:///text") {
                self.router.selection = 0
            }
            if url == URL(string: "homework:///results") {
                self.router.selection = 1
            }
        }
        
        .onAppear {
            incomeData.text = UIPasteboard.general.string ?? ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
