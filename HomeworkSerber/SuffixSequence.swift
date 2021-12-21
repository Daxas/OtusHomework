//
//  SuffixSequence.swift
//  HomeworkSerber
//
//  Created by Daria.S on 19.12.2021.
//

import Foundation

struct Suffix {
    var suffixPattern: String
    var count: Int
}

extension Suffix {
    var widgetText: String {
        return "<\(suffixPattern)> - \(String(count))"
    }
}

extension Suffix: Identifiable {
    public var id: String {
        self.suffixPattern
    }
}

struct SuffixSequence: Sequence {
    
    let suffixes: [Suffix]
    
    init(word: String) {
        self.suffixes = Self.makeSuffixArray(for: word)
    }
    
    func makeIterator() -> some IteratorProtocol {
        return SuffixIterator(suffixes: self.suffixes)
    }
    
    private static func makeSuffixArray(for word: String) -> [Suffix] {
        var suffixes = [Suffix]()
        let maxLength = word.count
        for index in 0...maxLength {
            let suffix = word.lowercased().suffix(index)
            if !suffix.isEmpty {
                suffixes.append(Suffix(suffixPattern: String(suffix), count: 1))
            }
        }
        return suffixes
    }
}

struct SuffixIterator: IteratorProtocol {
    
    private var suffixes: [Suffix]
    
    init(suffixes: [Suffix]) {
        self.suffixes = suffixes
    }
    
    mutating func next() -> Suffix? {
        defer {
                if !suffixes.isEmpty { suffixes.removeFirst() }
            }

            return suffixes.first
    }
}
