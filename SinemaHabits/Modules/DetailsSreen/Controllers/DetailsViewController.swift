import UIKit

class DetailsViewController: UIViewController {
    
    private let detailsView = DetailsView()

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
    
//    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
//        print("У нас ничего не работает!!!!")
//        navigationItem.title = ""
//        detailsView.image = ""
//        detailsView.rating = ""
//        detailsView.releaseFilmDate = ""
//        detailsView.descriptionFilm = ""
//    }
    
    private func processDate(
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
