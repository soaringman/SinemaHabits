import UIKit

final class MainView: UIView {
    
    var refresh: (() -> Void)?
    
    // UI Elements
    let errorView = ErrorView(frame: UIScreen.main.bounds)
    private let searchErrorView = SearchErrorView(frame: UIScreen.main.bounds)
    public lazy var tableView: UITableView = UITableView(frame: self.bounds, style: .plain)
    public lazy var refreshControl = UIRefreshControl()
    public lazy var searchController = UISearchController(searchResultsController: nil)
    public lazy var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 40))
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
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
        
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = "Search cinema..."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(named: "filter-list"), for: .bookmark, state: .normal)
        
        // ToDo переделать это говно
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.text = "SinemaHabits"
        
        errorView.isHidden = true
        searchErrorView.isHidden = true
        
    }
    
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
    
    @objc private func refreshData() {
        self.refresh?()
    }
}
