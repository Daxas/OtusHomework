//
//  HomeworkSerberApp.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

@main
struct HomeworkSerberApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .environmentObject(IncomeData())
        }
    }
}
