//
//  TVData.swift
//  SinemaHabits
//
//  Created by Даниил Симахин on 04.09.2022.
//

import Foundation

struct TVData: Codable {
    let page: Int
    let results: [TVDataResult]
}
