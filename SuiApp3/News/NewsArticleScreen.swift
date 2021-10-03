//
//  NewsArticleScreen.swift
//  NewsArticleScreen
//
//  Created by Александр Вяткин on 16.09.2021.
//

import SwiftUI

import NetworkingNews
import AppUI

import SDWebImageSwiftUI

struct NewsArticleScreen: View {
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                NavPopButton(destination: .root) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title)
                }
                Text(article.title ?? "")
                    .font(.largeTitle)
                
                WebImage(url: URL(string: article.urlToImage ?? ""))
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text(article.description ?? "")
                    .font(.caption2)
                Text(article.content ?? "")
                    .font(.caption2)
                
            }
        }
    }
}

/*struct NewsArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticleScreen()
    }
}*/
