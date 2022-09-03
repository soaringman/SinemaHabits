//
//  MovieDataResult.swift
//  SinemaHabits
//
//  Created by Даниил Симахин on 03.09.2022.
//

import Foundation

struct MovieDataResult: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String?
    let title: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
