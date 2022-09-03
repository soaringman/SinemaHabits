//
//  TVDataResult.swift
//  SinemaHabits
//
//  Created by Даниил Симахин on 04.09.2022.
//

import Foundation

struct TVDataResult: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String?
    let title: String?
    let voteAverage: Double
    let firstAirDate: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case name
    }
}
