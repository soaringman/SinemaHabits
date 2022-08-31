import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    private lazy var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
        setupDelegates()
        refresh()
        setupSearchBar()
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        searchBar.delegate = self
        mainView.searchController.searchBar.delegate = self
    }
    
    private func refresh() {
        mainView.refresh = {
            
            [weak self] in
            guard let self = self else { return }
            
            if self.isInternetAvailable() {
                self.mainView.getData()
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

    }
}

// MARK: - Extensions

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
