//
//  SuffixIterator.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 31.10.2021.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    
    let string: String
    var last: String.Index
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        self.last = string.endIndex
        self.offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < last else { return nil }
        
        let sub: Substring = string[offset..<last]
        string.formIndex(after: &offset)
        return sub
    }
}

struct SuffixSequence: Sequence {
    let string: String
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}

struct suffixItem: Equatable, Hashable, Comparable, Codable {
    static func < (lhs: suffixItem, rhs: suffixItem) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id: UUID = UUID()
    var name: String
    var count: Int = 1
}

class SuffixArray {
    public func getSuffixes(dataSource: [String], completion: @escaping ([suffixItem]) -> Void) {
        var suffixes: [suffixItem] = .init()
        
        for string in dataSource {
            let sequence = SuffixSequence(string: string.trimmingCharacters(in: .whitespacesAndNewlines))
            for suffix in sequence {
                let containItemIndex = suffixes.firstIndex(where: {$0.name == suffix})
                if containItemIndex == nil {
                    suffixes.append(suffixItem(name: String(suffix), count: 1))
                } else {
                    suffixes[containItemIndex!].count += 1
                }
                
            }
        }
        completion(suffixes)
    }
}
