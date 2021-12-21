//
//  WidgetDataProvider.swift
//  HomeworkSerber
//
//  Created by allme on 21.12.2021.
//

import Foundation

class WidgetDataProvider {
    
    static func getWidgetData(completion: @escaping ([Suffix]) -> Void) {
        let array = UserDefaults.standard.object(forKey:"SavedArray") as? [String] ?? [String]()
    }
    
}
