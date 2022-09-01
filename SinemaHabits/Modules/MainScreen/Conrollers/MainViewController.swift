import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    private var cinemaDataModel: [FilmAndTVResult] = []
    private var networkManager = NetworkManager()
    private var api = Api()
    private var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        getData()
        setupDelegates()
        refresh()
        setupSearchBar()
    }
    
    func getData() {
        let baseURL = api.baseURL
        //       let pageURL = "?page=\(pageNumber)"
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.searchController.searchBar.delegate = self
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
                    let alert = UIAlertController(title: "Ошибка",
                                                  message: "Проверьте интернет соединение",
                                                  preferredStyle: .alert)
                    let action = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
    }
    
    private func setupSearchBar() {
        self.navigationItem.titleView = mainView.titleLabel
        self.navigationItem.searchController = mainView.searchController
    }
    
    private var filteredCinema: [FilmAndTVResult] {
            return cinemaDataModel
            .filter({
                    $0.name.starts(with: searchText) || searchText.isEmpty
                })
        }
}

// MARK: - Extensions

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = mainView.searchController.searchBar.text ?? ""

            if self.searchText.isEmpty {
                mainView.setNotFoundView()
            } else {
                mainView.setIsFoundView()
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
        mainView.setIsFoundView()
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
            print("\(cell)")
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
