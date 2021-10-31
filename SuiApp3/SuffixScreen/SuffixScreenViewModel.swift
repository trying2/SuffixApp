//
//  SuffixDataSource.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 31.10.2021.
//

import Foundation
import SwiftUI

struct suffixDataSource {
    var all: [String] {
        return [
            "Dune",
            "Gune",
            "Fune",
            "Popune",
            "Venom: Let There Be Carnage",
            "Warnage",
            "Bondage",
            "Lell",
            "After We Fell",
            "Halloween Kills",
            "Army of Thieves",
            "Free Guy",
            "F9",
            "Hypnotic",
            "Night Teeth",
            "The Suicide Squad",
            "Old",
            "No Time to Die",
            "Venom",
            "Eternals",
            "Black Widow",
            "The Night House",
            "Snake Eyes: G.I. Joe Origins",
            "The Addams Family 2",
            "Shang-Chi and the Legend of the Ten Rings",
            "Dune",
            "Venom: Let There Be Carnage",
            "After We Fell",
            "Halloween Kills",
            "Army of Thieves",
            "Free Guy",
            "F9",
            "Hypnotic",
            "Night Teeth",
            "The Suicide Squad",
            "Old",
            "No Time to Die",
            "Venom",
            "Eternals",
            "Black Widow",
            "The Night House",
            "Snake Eyes: G.I. Joe Origins",
            "The Addams Family 2",
            "Shang-Chi and the Legend of the Ten Rings",
            "Nobody Sleeps in the Woods Tonight 2"
        ]
    }
}


final class SuffixScreenViewModel: ObservableObject {
    @Injected var suffixArrayService: SuffixArray?
    var dataSource = suffixDataSource().all
    @Published var suffixDataArrayFiltered: [suffixItem] = .init()
    var suffixDataArray: [suffixItem] = .init() {
        didSet {
            suffixDataArrayFiltered = suffixDataArray
        }
    }
    var displayTypeList = ["All", "TOP 10"]
    @Published var displayTypePicker = 0
    var sortTypeList = ["ASC", "DESC"]
    @Published var sortType = 0
    
    init() {
        self.getSuffixArray()
    }
    
    func search(searchText: String) {
        changeSuffixArrayMode(mode: displayTypePicker == 0 ? "ALL" : "TOP10")
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 {
            suffixDataArrayFiltered = suffixDataArrayFiltered.filter({$0.name.contains(searchText)})
        }
    }
    
    func getSuffixArray() {
        suffixArrayService?.getSuffixes(dataSource: dataSource, completion: { array in
            self.suffixDataArray = array
            self.sortSuffixArray(sortBy: "ASC")
            self.fillWidgetData()
        })
    }
    func fillWidgetData() {
        var widgetDataArray = suffixDataArray.filter({ suffixItem in
            suffixItem.name.count == 3
        })
        widgetDataArray.sort(by: {$0.count > $1.count})
        widgetDataArray = Array(widgetDataArray[..<10])
        let jsonData = try! JSONEncoder().encode(widgetDataArray)
        UserDefaults(suiteName: "group.trying.SuiApp3")!.set(jsonData, forKey: "widgetData")
    }
    func changeSuffixArrayMode(mode: String) {
        if mode == "TOP10" {
            suffixDataArrayFiltered = suffixDataArray.filter({ suffixItem in
                suffixItem.name.count == 3
            })
            suffixDataArrayFiltered.sort(by: {$0.count > $1.count})
            suffixDataArrayFiltered = Array(suffixDataArrayFiltered[..<10])
        } else {
            self.suffixDataArrayFiltered = self.suffixDataArray
        }
    }
    
    func sortSuffixArray(sortBy: String) {
        self.suffixDataArray.sort(by: { sortBy == "ASC" ? $0 < $1 : $0 > $1})
    }
}
