import UIKit
import SnapKit

final class DetailsView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var posterImage = UIImageView()
    private lazy var ratingLabel = UILabel()
    private lazy var releaseFilmDateLabel = UILabel()
    private lazy var descriptionFilmLabel = UILabel()
    private lazy var stackForReleaseAndRating = UIStackView(arrangedSubviews: [ratingLabel, releaseFilmDateLabel])
//    private lazy var stackForAllElements = UIStackView(arrangedSubviews: [posterImage,stackForReleaseAndRating, descriptionFilmLabel])
    
    var image = ""
    var rating = ""
    var releaseFilmDate = ""
    var descriptionFilm = ""
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    
    func setupUI() {
        backgroundColor = UIColor(named: "backGroudColor")
        stackForReleaseAndRating.axis = .horizontal
        stackForReleaseAndRating.distribution = .equalSpacing
    
        
//        stackForAllElements.axis = .vertical
//        stackForAllElements.distribution = .fill
//        stackForAllElements.spacing = CGFloat.top
        
        
        ratingLabel.text = rating
        releaseFilmDateLabel.text = releaseFilmDate
        descriptionFilmLabel.text = descriptionFilm
        descriptionFilmLabel.numberOfLines = 0
        descriptionFilmLabel.backgroundColor = .lightGray
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(image)"),
           let imageData = try? Data(contentsOf: imageUrl) {
            posterImage.image = UIImage(data: imageData)
        }
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
    }
    
    private func setupConstraints() {
        
        addSubview(posterImage)
        posterImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(450)
        }
        
        addSubview(stackForReleaseAndRating)
        stackForReleaseAndRating.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(CGFloat.top)
            $0.leading.trailing.equalTo(stackForReleaseAndRating).inset(10)

        }
        
//        addSubview(stackForAllElements)
//        stackForAllElements.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.bottom.equalToSuperview()
//            $0.leading.trailing.equalToSuperview()
//        }
        
        addSubview(descriptionFilmLabel)
        descriptionFilmLabel.snp.makeConstraints {
            $0.top.equalTo(stackForReleaseAndRating).inset(CGFloat.top)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
}

private extension CGFloat {
    static let leadingTrailing: CGFloat = 20
    static let top: CGFloat = 20
}
