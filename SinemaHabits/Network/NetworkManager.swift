//
//  NetworkManager.swift
//  AliasGame
//
//  Created by Артем Орлов on 27.07.2022.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func showData(results: [FilmAndTVResult])
    func showError()
}

final class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?

    private let api = Api()
    
    func fetchData(url: String) {
        api.decodeData(url: url) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let cinemas):
                DispatchQueue.main.async {
                self.delegate?.showData(results: cinemas.results)
                }
            case .failure(_):
                self.delegate?.showError()
            }
        }
    }
}

//        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=22f042b4faf775acd05fb5d467cfbffd"
       // for movie (films)
//        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=22f042b4faf775acd05fb5d467cfbffd&page=1"
       // for tv (serials)
//          let urlString = "https://api.themoviedb.org/3/discover/tv?api_key=22f042b4faf775acd05fb5d467cfbffd&page=2"
