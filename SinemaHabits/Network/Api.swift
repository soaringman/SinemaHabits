import Foundation

final class Api {
    
    enum Urls: String {
        case serialURL = "https://api.themoviedb.org/3/discover/tv?api_key=22f042b4faf775acd05fb5d467cfbffd&page=2"
        case cinemaURL = "https://api.themoviedb.org/3/discover/movie?api_key=22f042b4faf775acd05fb5d467cfbffd&page=1"
    }
    
    let baseURL = "https://api.themoviedb.org/3/discover/tv?api_key=22f042b4faf775acd05fb5d467cfbffd&page=2"
    
    func decodeData(url: String, completion: @escaping (Result<FilmAndTVModel, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Ошибка запроса: \(error)")
            }
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(FilmAndTVModel.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error)")
            }
        }.resume()
    }
}
