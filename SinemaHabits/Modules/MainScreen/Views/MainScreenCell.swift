import UIKit
import SnapKit

class MainScreenCell: UITableViewCell {
    
    // ReuseID
    static let reuseID = "Cell"
    
    // MARK: - UI elements
    
    public lazy var filmPoster = UIImageView()
    public lazy var filmTitle = UILabel()
    public lazy var filmDescription = UILabel()
    public lazy var filmStartDate = UILabel()
    private lazy var contentStack = UIStackView(arrangedSubviews: [filmTitle, filmDescription, filmStartDate])
    
    // MARK: - Initialization
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        self.selectionStyle = .none
        
        contentStack.axis = .vertical
        contentStack.distribution = .fillProportionally
        
        filmPoster.layer.cornerRadius = 15
        filmPoster.backgroundColor = .cyan
        
        filmTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        filmDescription.numberOfLines = 0
        filmDescription.lineBreakMode = .byWordWrapping
        filmDescription.minimumScaleFactor = 0.5
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(filmPoster)
        filmPoster.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(130)
        }
        
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.left.equalTo(filmPoster.snp.right).offset(10)
            $0.top.bottom.right.equalToSuperview().inset(10)
        }
    }
    
}
