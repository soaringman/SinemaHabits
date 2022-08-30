//
//  NetworkManager.swift
//  AliasGame
//
//  Created by Артем Орлов on 27.07.2022.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchCinema(completion: @escaping(CinemaModel) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=22f042b4faf775acd05fb5d467cfbffd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                let getData = try JSONDecoder().decode(CinemaModel.self, from: data)
                DispatchQueue.main.async {
                    completion(getData)
                    print(getData)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
