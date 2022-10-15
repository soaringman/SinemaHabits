import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var searchText: String = ""
    private lazy var mainView = MainView()
    private var networkManager = NetworkManager()
    private var api = Api()
    private var cinemaDataModel: [FilmAndTVResult] = []
    private var detailsViewController = DetailsViewController()
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupSearchBar()
        getData()
        refresh()
        setTargets()
    }
    
    // MARK: - Computed Properties
    
    private var filteredCinema: [FilmAndTVResult] {
        return cinemaDataModel
            .filter({
                $0.name?.starts(with: searchText) ?? false
            })
    }
}

// MARK: - UISearchBarDelegate

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

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
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
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCinema.count
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

// MARK: - Actions

@objc
private extension MainViewController {
    
    @objc private func tryAgainButtonClicked(_ sender: UIButton) {
        getData()
        mainView.setupTable()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func setTargets() {
        mainView.errorView.tryAgainButton.addTarget(self, action:
                                                        #selector(MainViewController().tryAgainButtonClicked(_:)),
                                                    for: .touchUpInside)
    }
    
    func setupUI() {
        self.view = mainView
    }
    
    func setupDelegates() {
        mainView.searchController.searchBar.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func setupSearchBar() {
        
        self.navigationItem.titleView = mainView.titleLabel
        self.navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func getData() {
        
        let baseURL = api.baseURL
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    func refresh() {
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
}
