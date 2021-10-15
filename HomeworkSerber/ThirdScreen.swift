//
//  ThirdScreen.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI

struct ThirdScreen: View {
    
    @Binding var isModal: Bool
    
    var body: some View {
        Button("Modal") {
            self.isModal.toggle()
        }.sheet(isPresented: $isModal) {
            VStack {
                Image(systemName: "megaphone")
                    .font(.largeTitle)
                    .padding(20)
                Text("I'm modal!")
                    .font(.largeTitle)
            }
            .onTapGesture {
                self.isModal.toggle()
            }
        }.font(.largeTitle)
    }
}

