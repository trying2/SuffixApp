//
//  SuffixScreen.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 31.10.2021.
//

import SwiftUI

struct SuffixScreen: View {
    @StateObject var viewmodel = SuffixScreenViewModel()
    @State var searchText: String = ""
    
    var allSuffixList: some View {
        VStack {
            Picker("Options", selection: $viewmodel.sortType) {
                ForEach(0 ..< viewmodel.sortTypeList.count) { index in
                    Text(viewmodel.sortTypeList[index])
                        .tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewmodel.sortType) { newValue in
                    viewmodel.sortSuffixArray(sortBy: newValue == 0 ? "ASC" : "DESC")
                }
            
            suffixList
        }
        
    }
    var suffixList: some View {
        List(self.viewmodel.suffixDataArrayFiltered, id: \.self) { suffix in
            HStack {
                Text(suffix.name)
                Spacer()
                Text("\(suffix.count)")
            }
            
        }
    }
    
    var searchTextComponent: some View {
        TextField("Search ...", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onChange(of: searchText) { text in
                self.viewmodel.search(searchText: searchText)
            }
    }
    
    var body: some View {
        VStack {
            searchTextComponent
            Picker("Options", selection: $viewmodel.displayTypePicker) {
                ForEach(0 ..< viewmodel.displayTypeList.count) { index in
                    Text(viewmodel.displayTypeList[index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: viewmodel.displayTypePicker) { newValue in
                viewmodel.changeSuffixArrayMode(mode: newValue == 0 ? "ALL" : "TOP10")
            }
            
            switch viewmodel.displayTypePicker {
            case 0:
                allSuffixList
            default:
                suffixList
            }
        }
    }
}

struct SuffixScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuffixScreen()
    }
}
