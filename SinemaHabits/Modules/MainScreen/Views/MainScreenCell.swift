import UIKit
import SnapKit

class MainScreenCell: UITableViewCell {
    
    // ReuseID
    static let reuseID = "Cell"
    
    // MARK: - UI elements
    
    private lazy var filmPoster = UIImageView()
    
    var cellImage: UIImage? {
        return filmPoster.image
    }
    
    private lazy var filmTitle = UILabel()
    private lazy var filmDescription = UILabel()
    private lazy var filmStartDate = UILabel()
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
        contentStack.distribution = .fillEqually
        
        filmPoster.layer.cornerRadius = 15
        filmPoster.backgroundColor = .black
        filmPoster.contentMode = .scaleToFill
        filmPoster.clipsToBounds = true
        
        filmTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        filmDescription.numberOfLines = 0
        filmDescription.lineBreakMode = .byWordWrapping
        filmDescription.minimumScaleFactor = 0.5
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(filmPoster)
        filmPoster.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.height.equalTo(130)
            $0.width.equalTo(100)
        }
        
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.left.equalTo(filmPoster.snp.right).offset(10)
            $0.top.bottom.right.equalToSuperview().inset(10)
        }
    }
    
    func setupCell(from model: FilmAndTVResult) {
        filmTitle.text = model.name
        filmDescription.text = model.overview
        filmStartDate.text = model.firstAirDate
        DispatchQueue.global().async {
            let url = "https://image.tmdb.org/t/p/w154\(model.posterPath)"
            guard let imageUrl = URL(string: url) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.filmPoster.image = UIImage(data: imageData)
            }
        }
    }
    
}
