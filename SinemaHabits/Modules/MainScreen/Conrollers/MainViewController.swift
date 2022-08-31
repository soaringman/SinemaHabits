import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    private lazy var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Верните серч бар"
        self.view = mainView
        searchBar.delegate = self
        refresh()
        setupSearchBar()
        NetworkManager.shared.fetchCinema { result in
            print(result.results)
            
            /*
             let id: Int
             let overview: String
             let popularity: Double
             let posterPath: String
             let releaseDate: String
             let title: String
             let voteAverage: Double
             */
        }
    }
    
    private func refresh() {
        mainView.refresh = {
            
            [weak self] in
            guard let self = self else { return }
            
            if self.isInternetAvailable() {
                //           model.refreshTable()
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
        navigationItem.hidesSearchBarWhenScrolling = false
        mainView.searchController.searchBar.delegate = self
        
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.endEditing(true)
    }
}
