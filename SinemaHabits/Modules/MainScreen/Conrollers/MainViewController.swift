import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var searchText: String = ""
    private lazy var mainView = MainView()
    private var networkManager = NetworkManager()
    private var api = Api()
//    private var cinemaDataModel: [Any] = []
    private var moviesDataModel: MovieData?
    private var tvDataModel: TVData?
    private var genres: CinemaGenres = .tv
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        setupSearchBar()
        getData(genres)
        refresh()
        
        // TO DO - refactor
        mainView.errorView.tryAgainButton.addTarget(self, action:
                                                        #selector(MainViewController().tryAgainButtonClicked(_:)),
                                                    for: .touchUpInside)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        self.view = mainView
    }
    
    private func setupDelegates() {
        
        mainView.searchController.searchBar.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func setupSearchBar() {
        
        self.navigationItem.titleView = mainView.titleLabel
        self.navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
 
    private func getData(_ genres: CinemaGenres) {
        
        //       let pageURL = "?page=\(pageNumber)"
        networkManager.delegate = self
        networkManager.fetchData(genres: genres)
    }
    
    private func refresh() {
        mainView.refresh = {
            
            [weak self] in
            guard let self = self else { return }
            
            if self.isInternetAvailable() {
                self.getData(self.genres)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.mainView.refreshControl.endRefreshing()
                })
            } else {
                self.mainView.refreshControl.endRefreshing()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.mainView.setupErrorView()
                })
            }
        }
    }
    // MARK: - Computed properties
    
//    private var filteredCinema: [FilmAndTVResult] {
//        return cinemaDataModel
//            .filter({
//                $0.name?.starts(with: searchText) ?? false || $0.title?.starts(with: searchText) ?? false
//            })
//    }
    
    // MARK: - Actions
    
    @objc private func tryAgainButtonClicked(_ sender: UIButton) {
        getData(genres)
        mainView.setupTable()
    }
}

    // MARK: - Extensions

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = mainView.searchController.searchBar.text ?? ""
        
//        if filteredCinema.isEmpty {
//            mainView.setupSearchError()
//        } else {
//            mainView.setupTable()
//        }
        
        mainView.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.endEditing(true)
        searchText = ""
        mainView.setupTable()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let alert = UIAlertController(title: "Сортировка",
                                      message: "Выберите фильтр для сортировки поиска",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "По фильмам",
                                      style: .default,
                                      handler: { _ in
            print("По фильмам")
            self.genres = .movie
            self.refresh()
        }))
        
        alert.addAction(UIAlertAction(title: "По сериалам",
                                      style: .default,
                                      handler: { _ in
            print("по сериалам")
            self.genres = .tv
            self.refresh()
        }))
        present(alert, animated: true)
    }
}

    // MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = moviesDataModel {
            return movies.results.count
        } else if let tv = tvDataModel {
            return tv.results.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCell.reuseID,
                                                    for: indexPath) as? MainScreenCell {
            if let movies = moviesDataModel {
                let data = movies.results[indexPath.row]
                cell.setupCell(from: data)
            } else if let tv = tvDataModel {
                let data = tv.results[indexPath.row]
                cell.setupCell(from: data)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}

    // MARK: - NetworkManagerDelegate

extension MainViewController: NetworkManagerDelegate {
    func showTV(results: TVData) {
        tvDataModel = results
        moviesDataModel = nil
        mainView.tableView.reloadData()
    }
    
    func showMovies(results: MovieData) {
        moviesDataModel = results
        tvDataModel = nil
        mainView.tableView.reloadData()
    }
    
    func showError() {
        print("Ошибка получения данных")
    }
}
