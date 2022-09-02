import UIKit

class DetailsViewController: UIViewController {
    
    private let detailsView = DetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(false)
        
        detailsView.setupUI()
        self.view = detailsView
        dismiss(animated: true)
    }
    
    func setData(model: FilmAndTVResult) {
        navigationItem.title = model.name
        detailsView.image = model.posterPath
        detailsView.rating = "Rating: \(model.voteAverage)"
        detailsView.releaseFilmDate = "Date: \(model.firstAirDate ?? "")"
        detailsView.descriptionFilm = model.overview
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        print("У нас ничего не работает!!!!")
        navigationItem.title = ""
        detailsView.image = ""
        detailsView.rating = ""
        detailsView.releaseFilmDate = ""
        detailsView.descriptionFilm = ""
    }
}
