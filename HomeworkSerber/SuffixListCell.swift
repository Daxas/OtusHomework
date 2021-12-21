//
//  SuffixListCell.swift
//  HomeworkSerber
//
//  Created by Daria.S on 15.12.2021.
//

import SwiftUI

public struct SuffixListCell: View {
    
    public init(suffix: String, count: Int) {
        self.suffix = suffix
        self.count = count
    }
    
    let suffix: String
    let count: Int
    
    public var body: some View {
        buttonContent
    }
    
    var buttonContent: some View {
        HStack {
            Text(suffix)
                .padding()
            Spacer()
            Text(String(count))
                .padding()
        }
    }
}
