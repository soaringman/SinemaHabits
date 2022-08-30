import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        
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
        navigationItem.titleView = mainView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
