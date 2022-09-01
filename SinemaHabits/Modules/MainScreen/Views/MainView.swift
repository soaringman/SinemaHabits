import UIKit

final class MainView: UIView {
    
    var refresh: (() -> Void)?
    
    // UI Elements
    
    lazy var tableView: UITableView = UITableView(frame: self.bounds, style: .plain)
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
        
        searchController.searchBar.placeholder = "Search cinema..."
        searchController.searchBar.tintColor = .black
        
        // ToDo переделать это говно
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.text = "Home"
        
    }
    
    @objc private func refreshData() {
        self.refresh?()
    }
}
