import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Верните серч бар"
        self.view = mainView
        mainView.searchBar.delegate = self
        refresh()
        setupSearchBar()
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
        mainView.setupSearchBar()
        let searchController = UISearchController(searchResultsController: nil)
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
 //       navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.titleView = mainView.searchBar
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Поиск фильма"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            mainView.searchBar.showsCancelButton = true
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.tintColor = .black
        mainView.searchBar.showsCancelButton = false
        //            mainView.searchBar.showsBookmarkButton = true
        mainView.searchBar.text = nil
        mainView.searchBar.endEditing(true)
        
        //            mainView.setIsFoundView()
        //            mainView.employeeTableView.reloadData()
    }
}
