import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupSearchBar()
        navigationItem.titleView = mainView.searchBar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
