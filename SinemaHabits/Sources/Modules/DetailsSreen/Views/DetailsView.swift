import UIKit
import SnapKit

final class DetailsView: UIView {
    
    // MARK: - Properties
    
    var image = ""
    var rating = ""
    var releaseFilmDate = ""
    var descriptionFilm = ""
    
    // MARK: - UI Elements
    
    private lazy var scrollView = UIScrollView()
    private lazy var viewForPosterImage = UIView()
    private lazy var posterImage = UIImageView()
    private lazy var ratingLabel = UILabel()
    private var releaseFilmDateLabel = UILabel()
    private lazy var descriptionFilmLabel = UILabel()
    private lazy var stackForReleaseAndRating = UIStackView(arrangedSubviews: [ratingLabel, releaseFilmDateLabel])
    private lazy var stackForAllElements = UIStackView(
        arrangedSubviews: [stackForReleaseAndRating, descriptionFilmLabel])
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = UIColor(named: "backGroudColor")
        stackForReleaseAndRating.axis = .horizontal
        stackForReleaseAndRating.distribution = .fillEqually
        
        stackForAllElements.axis = .vertical
        stackForAllElements.distribution = .fill
        stackForAllElements.spacing = 16
        
        releaseFilmDateLabel.textAlignment = .right
        
        descriptionFilmLabel.numberOfLines = 0
        descriptionFilmLabel.lineBreakMode = .byWordWrapping
        
        posterImage.contentMode = .scaleAspectFit
        
        viewForPosterImage.backgroundColor = .black
        
        ratingLabel.text = rating
        descriptionFilmLabel.text = descriptionFilm
        
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(image)"),
           let imageData = try? Data(contentsOf: imageUrl) {
            posterImage.image = UIImage(data: imageData)
        }
        
        releaseFilmDateLabel.text = releaseFilmDate
    }
}

// MARK: - Private methods

private extension DetailsView {
    
    func setupConstraints() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        addSubview(viewForPosterImage)
        viewForPosterImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        viewForPosterImage.addSubview(posterImage)
        posterImage.snp.makeConstraints {
            $0.top.centerX.height.equalToSuperview()
        }
        
        addSubview(stackForAllElements)
        stackForAllElements.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

private extension CGFloat {
    static let leadingTrailing: CGFloat = 20
    static let top: CGFloat = 20
}
