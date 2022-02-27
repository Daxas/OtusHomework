//
//  SuffixResultViewModel.swift
//  HomeworkSerber
//
//  Created by Daria.S on 19.12.2021.
//

import Foundation

struct History {
    var text: String
    var searchingTime: Double
}

extension History: Identifiable {
    public var id: String {
        self.text
    }
}

final class SuffixResultViewModel: ObservableObject {
    
    @Published var sortedResults: [Suffix] = .init()
    @Published var reversedSortedResults: [Suffix] = .init()
    @Published var topTenResults: [Suffix] = .init()
    @Published var history: [History] = .init()
    
    var text: String = ""
    
    init(topTenSuffixLenght: Int = 3) {
        self.topTenSuffixLenght = topTenSuffixLenght
    }
    
    private let topTenSuffixLenght: Int
    
    private var workItem: DispatchWorkItem?
    
    func process() {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem {
            let startTime = CFAbsoluteTimeGetCurrent()
            self.proceedText()
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            DispatchQueue.main.async {
                self.history.append(History(text: self.text, searchingTime: timeElapsed))
            }
        }
        workItem = newWorkItem
        DispatchQueue.global().async(execute: newWorkItem)
    }
    
    private func proceedText() {
        let words: [String] = self.text.components(separatedBy: [" ", ".", ",", "!", "?", ":", ";", "(", ")"])
        var suffixDictionary = [String : Int]()
        for word in words {
            let suffixSequence = SuffixSequence(word: word)
            for suffix in suffixSequence.suffixes {
                if suffixDictionary.keys.contains(suffix.suffixPattern) {
                    suffixDictionary[suffix.suffixPattern]! += 1
                } else {
                    suffixDictionary[suffix.suffixPattern] = 1
                }
            }
        }
        
        makeSortedResults(for: suffixDictionary)
        makeTopTenResults(for: suffixDictionary)
        makeWidgetResults(for: suffixDictionary)
    }
    
    private func makeSortedResults(for suffixDictionary: [String: Int]) {
        let sortedKeys = suffixDictionary.sorted( by: { $0.0 > $1.0 })
        var arr = [Suffix]()
        for (key, value) in sortedKeys {
            arr.append(Suffix(suffixPattern: key, count: value))
        }
        DispatchQueue.main.async {
            self.sortedResults = arr
            self.reversedSortedResults = arr.reversed()
        }
    }
    
    private func makeTopTenResults(for suffixDictionary: [String: Int]) {
        let filteredDict = suffixDictionary.filter { $0.key.count == self.topTenSuffixLenght }
        let sortedValues = filteredDict.sorted( by: { $0.1 > $1.1 })
        let topTen = sortedValues.prefix(10)
        var arr = [Suffix]()
        for (key, value) in topTen {
            arr.append(Suffix(suffixPattern: key, count: value))
        }
        DispatchQueue.main.async {
            self.topTenResults = arr
        }
    }
    
    private func makeWidgetResults(for suffixDictionary: [String: Int]) {
        let filteredDict = suffixDictionary.filter { $0.key.count > self.topTenSuffixLenght - 1 }
        let sortedValues = filteredDict.sorted( by: { $0.1 > $1.1 })
        let topTen = sortedValues.prefix(3)
        var arr = [String]()
        for (key, value) in topTen {
            arr.append(Suffix(suffixPattern: key, count: value).widgetText)
        }
        UserDefaults(suiteName: "group.serber.homework")?.set(arr, forKey: "SavedArray")
    }
    
}
