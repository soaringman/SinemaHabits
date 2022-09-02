import UIKit
import SnapKit

final class DetailsView: UIView {

//  MARK: - UI Elements
    private lazy var posterImage = UIImageView()
    private lazy var ratingLabel = UILabel()
    private lazy var releaseFilmDateLabel = UILabel()
    private lazy var descriptionFilmLabel = UILabel()
    private lazy var stackForReleaseAndRating = UIStackView(arrangedSubviews: [ratingLabel, releaseFilmDateLabel])

    
    
// MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Private methods

    private func setupUI() {
        
        backgroundColor = .gray
        posterImage.backgroundColor = .yellow
        stackForReleaseAndRating.backgroundColor = .purple
        stackForReleaseAndRating.axis = .horizontal
        stackForReleaseAndRating.distribution = .fillProportionally
        ratingLabel.text = "sjdbaksjbksbdCJHKsdc"
        releaseFilmDateLabel.text = "09-08-2022"
        descriptionFilmLabel.text = "lkdfnksdnVSV M.NSV.SNCLKNCKJSABDCKLQNDKJSdncvalsnjsdv ./sdnvksjnvldncvkjsadnvksdBFKWHFBKJDSVSDLKVNSKDVBKSAVNLwjfiuwehfweNF"
        descriptionFilmLabel.numberOfLines = 0
        
    }
    
    private func setupConstraints() {
        
        addSubview(posterImage)
        posterImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        
        addSubview(stackForReleaseAndRating)
        stackForReleaseAndRating.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(CGFloat.top)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        addSubview(descriptionFilmLabel)
        descriptionFilmLabel.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(CGFloat.leadingTrailing)
        }
    }
}

private extension CGFloat {
    static let leadingTrailing: CGFloat = 20
    static let top: CGFloat = 20
}


