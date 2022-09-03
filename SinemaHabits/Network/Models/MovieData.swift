//
//  MovieData.swift
//  SinemaHabits
//
//  Created by Даниил Симахин on 04.09.2022.
//

import Foundation

struct MovieData: Codable {
    let page: Int
    let results: [MovieDataResult]
}
