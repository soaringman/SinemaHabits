//
//  NetworkManager.swift
//  AliasGame
//
//  Created by Артем Орлов on 27.07.2022.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchCinema(completion: @escaping(FilmAndTVModel) -> Void) {
        //example
//        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=22f042b4faf775acd05fb5d467cfbffd"
        //for movie (films)
//        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=22f042b4faf775acd05fb5d467cfbffd&page=1"
        //for tv (serials)
          let urlString = "https://api.themoviedb.org/3/discover/tv?api_key=22f042b4faf775acd05fb5d467cfbffd"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription, "Данные не были получены")
            }
            do {
                let getData = try JSONDecoder().decode(FilmAndTVModel.self, from: data)
                DispatchQueue.main.async {
                    completion(getData)
                    print(getData)
                }
            } catch {
                print(error.localizedDescription, "Данные не распарсились")
            }
        }.resume()
    }
    
}
