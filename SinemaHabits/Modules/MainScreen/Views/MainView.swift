import UIKit

class MainView: UIView {
    
    let searchBar = UISearchBar()
    
    func setupSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(
            red: 247.0/255.0,
            green: 247.0/255.0,
            blue: 248.0/255.0,
            alpha: 1)
        
        searchBar.backgroundColor = .white
        searchBar.showsBookmarkButton = true
        searchBar.sizeToFit()
        searchBar.placeholder = "Введи название фильма"
        searchBar.setValue("Отмена", forKey: "cancelButtonText")

    }
}
