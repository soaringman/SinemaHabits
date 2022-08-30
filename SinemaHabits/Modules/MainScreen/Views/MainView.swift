import UIKit

class MainView: UIView {
    
    var refresh: (() -> Void)?
    
    // UI Elements
    
    public lazy var searchBar = UISearchBar()
    private lazy var tableView: UITableView = UITableView(frame: self.bounds, style: .plain)
    public lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupDelegates()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
    
    private func setupUI() {
        tableView.register(MainScreenCell.self, forCellReuseIdentifier: MainScreenCell.reuseID)
        tableView.backgroundColor = .white
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        self.refresh?()
    }
    
    // MARK: - Public methods
    
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

// MARK: - UITableViewDataSource

extension MainView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCell.reuseID,
                                                    for: indexPath) as? MainScreenCell {
            
//            let data = self.datas[indexPath.row]
            cell.filmDescription.text = "Привет!"
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MainView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
