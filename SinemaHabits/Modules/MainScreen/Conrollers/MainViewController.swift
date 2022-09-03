import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var searchText: String = ""
    private lazy var mainView = MainView()
    private var networkManager = NetworkManager()
    private var api = Api()
    private var cinemaDataModel: [FilmAndTVResult] = []
    private var detailsViewController = DetailsViewController()
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupSearchBar()
        getData()
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
 
    private func getData() {
        
        let baseURL = api.baseURL
        //       let pageURL = "?page=\(pageNumber)"
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    private func refresh() {
        mainView.refresh = {
            
            [weak self] in
            guard let self = self else { return }
            
            if self.isInternetAvailable() {
                self.getData()
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
    
    private func setupSearchBar() {
        
        self.navigationItem.titleView = mainView.titleLabel
        self.navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Computed properties
    
    private var filteredCinema: [FilmAndTVResult] {
        return cinemaDataModel
            .filter({
                $0.name?.starts(with: searchText) ?? false ||
                $0.title?.starts(with: searchText) ?? false
            })
    }
    
    // MARK: - Actions
    
    @objc private func tryAgainButtonClicked(_ sender: UIButton) {
        getData()
        mainView.setupTable()
    }
}

    // MARK: - Extensions

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = mainView.searchController.searchBar.text ?? ""
        
        if filteredCinema.isEmpty {
            mainView.setupSearchError()
        } else {
            mainView.setupTable()
        }
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
        }))
        
        alert.addAction(UIAlertAction(title: "По сериалам",
                                      style: .default,
                                      handler: { _ in
            print("по сериалам")
        }))
        
        present(alert, animated: true)
    }
}

    // MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCinema.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MainScreenCell.reuseID,
            for: indexPath) as? MainScreenCell {
            
                let data = filteredCinema[indexPath.row]
                cell.setupCell(from: data)
                return cell
            }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsViewController.setData(model: cinemaDataModel[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

    // MARK: - NetworkManagerDelegate

extension MainViewController: NetworkManagerDelegate {
    func showData(results: [FilmAndTVResult]) {
        cinemaDataModel = results
        mainView.tableView.reloadData()
    }
    
    func showError() {
        print("Ошибка получения данных")
    }
}
