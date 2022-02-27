//
//  HistoryScreen.swift
//  HomeworkSerber
//
//  Created by Дарья Сербер on 27.02.2022.
//

import SwiftUI

struct HistoryScreen: View {
    
    @EnvironmentObject var model: SuffixResultViewModel
    
    var body: some View {
        List(model.history) { item in
            HistoryCell(text: item.text, searchingTime: item.searchingTime)
        }
    }
}
