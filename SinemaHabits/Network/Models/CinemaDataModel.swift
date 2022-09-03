////
////  CinemaDataModel.swift
////  SinemaHabits
////
////  Created by Алексей Гуляев on 31.08.2022.
////
//
//import Foundation
//
//struct FilmAndTVModel: Codable {
//    let page: Int
//    let results: [FilmAndTVResult]
//}
//
//// MARK: - Result
//struct FilmAndTVResult: Codable {
//    let id: Int
//    let overview: String
//    let popularity: Double
//    let posterPath: String
//    let releaseDate: String?
//    let title: String?
//    let voteAverage: Double
//    // for TV (serials)
//    let firstAirDate: String?
//    let name: String? // optional
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case id
//        case overview
//        case popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title
//        case voteAverage = "vote_average"
//        // for TV (serials)
//        case firstAirDate = "first_air_date"
//        case name
//    }
//}
//
///*
// example movie:
//https://api.themoviedb.org/3/discover/movie?api_key
// =<<api_key>>&language=en-US&sort_by=popularity.
// desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
// */
//
///*
//example serials: https://api.themoviedb.org/3/discover/tv?api_key=<<api_key>>&language=en-US
// &sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false
// &with_watch_monetization_types=flatrate&with_status=0&with_type=0
//*/
//
///*
// example actors
// https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=<<api_key>>&language=en-US
// */
//
//// how get image
//// https://image.tmdb.org/t/p/original/av3r9EPMEpCBwsOrrxdNcy3Forz.jpg
