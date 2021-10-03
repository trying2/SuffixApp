//
//  Array.swift
//  Array
//
//  Created by Александр Вяткин on 18.09.2021.
//

import Foundation

extension RandomAccessCollection where Self.Element : Identifiable {
    public func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: {AnyHashable($0.id) == AnyHashable(item.id)}) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
}

