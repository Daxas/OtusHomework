//
//  HistoryCell.swift
//  HomeworkSerber
//
//  Created by Дарья Сербер on 27.02.2022.
//

import SwiftUI

public struct HistoryCell: View {
    
    public init(text: String, searchingTime: Double) {
        self.text = text
        self.searchingTime = searchingTime
    }
    
    let text: String
    let searchingTime: Double
    
    public var body: some View {
        buttonContent
    }
    
    var buttonContent: some View {
        HStack {
            Text(text)
                .lineLimit(2)
                .padding()
            Spacer()
            Text(searchingTime.description)
                .padding()
                .lineLimit(2)
        }
    }
}
