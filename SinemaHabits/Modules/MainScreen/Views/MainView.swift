import UIKit

final class MainView: UIView {
    
    var refresh: (() -> Void)?
    
    // UI Elements
    
    private lazy var tableView: UITableView = UITableView(frame: self.bounds, style: .plain)
    public lazy var refreshControl = UIRefreshControl()
    public lazy var searchController = UISearchController(searchResultsController: nil)
    public lazy var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 40))
    private var networkManager = NetworkManager()
    private var api = Api()
    
    private var cinemaDataModel: [FilmAndTVResult] = []
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupDelegates()
        getData()
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
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        searchController.searchBar.placeholder = "Search cinema..."
        searchController.searchBar.tintColor = .black
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        
        // ToDo переделать это говно
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.text = "Home"
        
    }
    
    func getData() {
        let baseURL = api.baseURL
        //       let pageURL = "?page=\(pageNumber)"
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    @objc private func refreshData() {
        self.refresh?()
    }
}

// MARK: - UITableViewDataSource

extension MainView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemaDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCell.reuseID,
                                                    for: indexPath) as? MainScreenCell {
            
            let data = cinemaDataModel[indexPath.row]
            cell.setupCell(from: data)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}

extension MainView: NetworkManagerDelegate {
    func showData(results: [FilmAndTVResult]) {
        cinemaDataModel = results
        tableView.reloadData()
    }
    
    func showError() {
        print("Ошибка получения данных")
    }
}
