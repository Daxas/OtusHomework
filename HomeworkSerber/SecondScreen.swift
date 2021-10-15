//
//  SecondScreen.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

final class SecondScreenViewModel: ObservableObject {
    
    @Published private(set) var symbolNames = [
        SFSymbol(name: "seal"),
        SFSymbol(name: "heart"),
        SFSymbol(name: "triangle"),
        SFSymbol(name: "bag"),
        SFSymbol(name: "signature"),
        SFSymbol(name: "flame"),
        SFSymbol(name: "drop"),
        SFSymbol(name: "bolt"),
        SFSymbol(name: "hare"),
        SFSymbol(name: "pawprint"),
        SFSymbol(name: "ant"),
        SFSymbol(name: "ladybug"),
        SFSymbol(name: "leaf"),
        SFSymbol(name: "clock"),
        SFSymbol(name: "alarm"),
        SFSymbol(name: "hourglass"),
        SFSymbol(name: "pensil"),
        SFSymbol(name: "airplane"),
        SFSymbol(name: "car"),
        SFSymbol(name: "bus"),
        SFSymbol(name: "tram"),
        SFSymbol(name: "ferry")
    ]
    
}

struct SFSymbol {
    let name: String
}

extension SFSymbol: Identifiable {
    var id: String {
        name
    }
}

struct SecondScreen: View {
    
    @EnvironmentObject var viewModel: SecondScreenViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.symbolNames) { item in
                    IconCell(title: item.name)
                }
            }
            .navigationTitle("Symbols")
            .listStyle(.sidebar)
            .overlay(NavigationLink(destination: IconView(icon: Image(systemName: viewModel.symbolNames[1].name))
                                                            .navigationTitle(viewModel.symbolNames[1].name.uppercased() + " symbol"),
                                    isActive: $router.isSymbolShowed) {
                EmptyView().hidden()
            })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct IconCell: View {
    let title: String
    
    var body: some View {
        NavigationLink(destination: IconView(icon: Image(systemName: title))
                        .navigationTitle(title.uppercased() + " symbol")) {
            Text(title)
        }
    }
}

struct IconView: View {
    
    let icon: Image
    
    var body: some View {
        Text(icon)
            .font(Font.system(size: 200))
    }
}
