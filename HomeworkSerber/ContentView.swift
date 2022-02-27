//
//  ContentView.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var model: SuffixResultViewModel
    
    var body: some View {
        TabView(selection: $router.selection) {
            TextScreen()
                .environmentObject(model)
                .tabItem {
                    Text("Text")
                    Image(systemName: "menucard")
                }
                .tag(0)
            ResultsScreen()
                .environmentObject(model)
                .tabItem {
                    Text("Results")
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            HistoryScreen()
                .environmentObject(model)
                .tabItem {
                    Text("History")
                    Image(systemName: "clock")
                }
                .tag(2)
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
            model.text = UIPasteboard.general.string ?? ""
        }
    }
}
