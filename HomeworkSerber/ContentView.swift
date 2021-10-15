//
//  ContentView.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @State private var isModal = false
    
    var body: some View {
        TabView(selection: $router.selection) {
            FirstScreen()
                .tabItem {
                    Text("First")
                    Image(systemName: "star")
                }
                .tag(0)
            SecondScreen()
                .tabItem {
                    Text("Second")
                    Image(systemName: "message")
                }
                .tag(1)
            ThirdScreen(isModal: $isModal)
                .tabItem {
                    Text("Third")
                    Image(systemName: "person")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
