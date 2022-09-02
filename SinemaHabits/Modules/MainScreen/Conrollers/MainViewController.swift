import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    private var networkManager = NetworkManager()
    private var api = Api()
    private var searchText: String = ""
    private var cinemaDataModel: [FilmAndTVResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.errorView.tryAgainButton.addTarget(self, action:
                                                        #selector(MainViewController().tryAgainButtonClicked(_:)),
                                                    for: .touchUpInside)
        self.view = mainView
        getData()
        setupDelegates()
        refresh()
        setupSearchBar()
    }
    
    @objc func tryAgainButtonClicked(_ sender: UIButton) {
        getData()
        mainView.setupTable()
    }
    
    func getData() {
        let baseURL = api.baseURL
        //       let pageURL = "?page=\(pageNumber)"
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        mainView.searchController.searchBar.delegate = self
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
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
    
    private var filteredCinema: [FilmAndTVResult] {
        return cinemaDataModel
            .filter({
                $0.name?.starts(with: searchText) ?? false || $0.title?.starts(with: searchText) ?? false
            })
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
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCinema.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCell.reuseID,
                                                    for: indexPath) as? MainScreenCell {
            
            let data = filteredCinema[indexPath.row]
            cell.setupCell(from: data)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}

extension MainViewController: NetworkManagerDelegate {
    func showData(results: [FilmAndTVResult]) {
        cinemaDataModel = results
        mainView.tableView.reloadData()
    }
    
    func showError() {
        print("Ошибка получения данных")
    }
}
