//
//  FirstScreen.swift
//  HomeworkSerber
//
//  Created by Daxas on 03.10.2021.
//

import SwiftUI
import UIKit
import Foundation

struct TextScreen: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var incomeData: IncomeData

    var body: some View {
        VStack {
            Spacer(minLength: 60)
            Text("Enter your text")
                .padding()
            TextEditor(text: $incomeData.text)
                .colorMultiply(.gray)
                .cornerRadius(10)
                .padding()
            MyCustomButton() {
                router.selection = 1
            }
            .frame(width: 200, height: 200, alignment: .center)
        }
    }
}


struct MyCustomButton: UIViewRepresentable {
    
    let tapAction: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> UIButton {
        let b = UIButton(type: .system)
        b.tintColor = .white
        b.layer.cornerRadius = 100
        b.backgroundColor = .purple.withAlphaComponent(0.7)
        b.setTitle("Proceed", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        b.addTarget(context.coordinator, action: #selector(Coordinator.handler), for: .touchUpInside)
        return b
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        context.coordinator.tapAction = tapAction
    }
    
}

extension MyCustomButton {
    class Coordinator {
        var tapAction: (() -> Void)?
        
        @objc func handler() {
            tapAction?()
        }
    }
}
