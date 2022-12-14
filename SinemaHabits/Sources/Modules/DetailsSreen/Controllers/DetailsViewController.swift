import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let detailsView = DetailsView()
    
    // MARK: - Life Cicle

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(false)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "customBlack")
        
        detailsView.setupUI()
        self.view = detailsView
        dismiss(animated: true)
    }
    
    // MARK: - Public Methods
    
    func setData(model: FilmAndTVResult) {
        navigationItem.title = model.name 
        detailsView.image = model.posterPath
        detailsView.rating = "Rating: \(model.voteAverage)"
        guard let newDate = processDate(string: model.firstAirDate ?? "",
                                  fromFormat: "yyyy-MM-dd",
                                        toFormat: "dd.MM.yyyy") else { return }
        detailsView.releaseFilmDate = "Date: \(newDate)"
        detailsView.descriptionFilm = model.overview
    }
}

// MARK: - Private Methods

private extension DetailsViewController {
    
    func processDate(
        string: String,
        fromFormat: String = "ddMMyyyy",
        toFormat: String = "dd MMMM yyyy") -> String? {
        let formatter = DateFormatter()

        formatter.dateFormat = fromFormat
        guard let date = formatter.date(from: string) else { return nil }

        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
}
