import Foundation

enum CinemaGenres: String {
    case movie
    case tv
}

final class Api {

    let baseURL = "https://api.themoviedb.org/3/discover"
    let apiKey = "22f042b4faf775acd05fb5d467cfbffd"
    
    private func getURL(data: CinemaGenres) -> String {
        var url = String()
        switch data {
        case .movie:
            url = "\(baseURL)/\(data.rawValue)?api_key=\(apiKey)&page=\(1)"
        case .tv:
            url = "\(baseURL)/\(data.rawValue)?api_key=\(apiKey)&page=\(1)"
        }
        return url
    }
    
    func decodeMovieData(completion: @escaping (Result<MovieData, Error>) -> Void) {
        guard let url = URL(string: getURL(data: .movie)) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Ошибка запроса: \(error)")
            }
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(MovieData.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error)")
            }
        }.resume()
    }
    
    func decodeTVData(completion: @escaping (Result<TVData, Error>) -> Void) {
        guard let url = URL(string: getURL(data: .tv)) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Ошибка запроса: \(error)")
            }
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(TVData.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error)")
            }
        }.resume()
    }
    
//    func decodeData(url: String, completion: @escaping (Result<FilmAndTVModel, Error>) -> Void) {
//        guard let url = URL(string: url) else {return}
//        let session = URLSession.shared
//        session.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                print("Ошибка запроса: \(error)")
//            }
//            guard let data = data else {return}
//            
//            do {
//                let json = try JSONDecoder().decode(FilmAndTVModel.self, from: data)
//                completion(.success(json))
//            } catch let error {
//                print("Ошибка парсинга: \(error)")
//            }
//        }.resume()
//    }
}
