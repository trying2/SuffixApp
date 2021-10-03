//
//  MovieList.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 03.10.2021.
//

import Foundation

public struct MovieList: Codable, Hashable {

    public var page: Int
    public var totalPages: Int
    public var totalResults: Int
    public var results: [Movie]

    public init(page: Int, totalPages: Int, totalResults: Int, results: [Movie]) {
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.results = results
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(results, forKey: .results)
    }
}

