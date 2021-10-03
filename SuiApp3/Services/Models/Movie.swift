//
//  Movie.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 03.10.2021.
//
import Foundation

public struct Movie: Codable, Hashable, Identifiable {

    public var genreIds: [Double]
    public var originalLanguage: String
    public var originalTitle: String
    public var posterPath: String
    public var video: Bool
    public var id: Int
    public var voteCount: Double
    public var overview: String
    public var releaseDate: String
    public var voteAverage: Double
    public var title: String
    public var adult: Bool
    public var backdropPath: String
    public var popularity: Double
    public var mediaType: String

    public init(genreIds: [Double], originalLanguage: String, originalTitle: String, posterPath: String, video: Bool, id: Int, voteCount: Double, overview: String, releaseDate: String, voteAverage: Double, title: String, adult: Bool, backdropPath: String, popularity: Double, mediaType: String) {
        self.genreIds = genreIds
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.video = video
        self.id = id
        self.voteCount = voteCount
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.title = title
        self.adult = adult
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.mediaType = mediaType
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case id
        case voteCount = "vote_count"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case title
        case adult
        case backdropPath = "backdrop_path"
        case popularity
        case mediaType = "media_type"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(video, forKey: .video)
        try container.encode(id, forKey: .id)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(title, forKey: .title)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(mediaType, forKey: .mediaType)
    }
}

