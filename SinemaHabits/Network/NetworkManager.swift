//
//  NetworkManager.swift
//  AliasGame
//
//  Created by Артем Орлов on 27.07.2022.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func showTV(results: TVData)
    func showMovies(results: MovieData)
    func showError()
}

final class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?

    private let api = Api()
    
    func fetchData(genres: CinemaGenres) {
        switch genres {
        case .movie:
            api.decodeMovieData { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.delegate?.showMovies(results: movies)
                    }
                case .failure(_):
                    self.delegate?.showError()
                }
            }
        case .tv:
            api.decodeTVData { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let tv):
                    DispatchQueue.main.async {
                    self.delegate?.showTV(results: tv)
                    }
                case .failure(_):
                    self.delegate?.showError()
                }
            }
        }
    }
    
}

//        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=22f042b4faf775acd05fb5d467cfbffd"
       // for movie (films)
//        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=22f042b4faf775acd05fb5d467cfbffd&page=1"
       // for tv (serials)
//          let urlString = "https://api.themoviedb.org/3/discover/tv?api_key=22f042b4faf775acd05fb5d467cfbffd&page=2"
