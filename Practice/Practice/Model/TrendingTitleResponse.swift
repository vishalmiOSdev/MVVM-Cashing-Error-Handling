//
//  TrendingTitleResponse.swift
//  Practice
//
//  Created by Vishal Manhas on 30/11/24.
//

import Foundation
import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    var page: Int
    var results: [Movie]
}

// MARK: - Movie
struct Movie: Codable,Identifiable,Hashable {
    var backdropPath: String?
    var id: Int
    var title: String
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var mediaType: String
    var adult: Bool
    var originalLanguage: String
    var genreIDs: [Int]
    var popularity: Double
    var releaseDate: String?
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDs = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
