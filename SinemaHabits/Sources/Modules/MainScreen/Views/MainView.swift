import UIKit

final class MainView: UIView {
    
    // MARK: - Properties
    
    var refresh: (() -> Void)?
    
    // MARK: - UI Elements
    
    let errorView = ErrorView(frame: UIScreen.main.bounds)
    
    lazy var tableView: UITableView = UITableView(frame: self.bounds, style: .plain)
    lazy var refreshControl = UIRefreshControl()
    lazy var searchController = UISearchController(searchResultsController: nil)
    lazy var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 40))
    
    private let searchErrorView = SearchErrorView(frame: UIScreen.main.bounds)
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension MainView {
    
    func setupErrorView() {
        addSubview(errorView)
        errorView.isHidden = false
        tableView.isHidden = true
    }
    
    func setupSearchError() {
        addSubview(searchErrorView)
        searchErrorView.isHidden = false
        tableView.isHidden = true
        tableView.reloadData()
    }
    
    func setupTable() {
        searchErrorView.isHidden = true
        errorView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
}

// MARK: - Actions

@objc
private extension MainView {
    
    @objc private func refreshData() {
        self.refresh?()
    }
}

// MARK: - Private methods

private extension MainView {
    
    func setupUI() {
        
        tableView.register(MainScreenCell.self, forCellReuseIdentifier: MainScreenCell.reuseID)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = "Search cinema..."
        searchController.searchBar.tintColor = UIColor(named: "customBlack")
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.text = "SinemaHabits"
        
        errorView.isHidden = true
        searchErrorView.isHidden = true
    }
    
    func setupConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
}
