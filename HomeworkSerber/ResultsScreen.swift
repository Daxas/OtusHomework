//
//  SecondScreen.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

struct ResultsScreen: View {
    
    @EnvironmentObject var incomeData: IncomeData
    
    @StateObject var suffixResults = SuffixResultViewModel()
    
    @State var resultsChoice = 0
    @State var isASCSorted = true
    
    var body: some View {
        resultsPicker
            .onAppear {
                suffixResults.text = incomeData.text
            }
    }
    
    var resultsPicker: some View {
        ScrollView {
            VStack {
                Picker.init("Results", selection: $resultsChoice) {
                    ForEach(0 ..< Self.resultsTypes.count) { index in
                        Text(Self.resultsTypes[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if resultsChoice == 0 {
                    sortedList
                } else if resultsChoice == 1 {
                    topTenList
                }
            }
            .frame(minHeight: 1000)
        }
    }

    private static let resultsTypes = ["Sorted", "Top 10"]
    
    var sortedList: some View {
        VStack{
            Toggle(isOn: $isASCSorted) {
                Text("Sorting type ⬆/⬇")
            }
            .padding()
            
            List(isASCSorted ? suffixResults.sortedResults : suffixResults.reversedSortedResults) { item in
                SuffixListCell(suffix: item.suffixPattern, count: item.count)
            }
        }
    }
    
    var topTenList: some View {
        List(suffixResults.topTenResults) { item in
            SuffixListCell(suffix: item.suffixPattern, count: item.count)
        }
    }
    
}
