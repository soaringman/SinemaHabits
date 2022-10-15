import UIKit

class SearchErrorView: UIView {
    
    private let loupe = UIImageView()
    private let searchErrorLabel = UILabel()
    private let tryToCorrectLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "customWhite")
        
        loupe.image = UIImage(named: "loupe")
        
        searchErrorLabel.text = "Мы никого не нашли"
        searchErrorLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        searchErrorLabel.textColor = UIColor(named: "customBlack")
        searchErrorLabel.contentMode = .scaleAspectFit
        searchErrorLabel.textAlignment = .center
        
        tryToCorrectLabel.text = "Попробуйте скорректировать запрос"
        tryToCorrectLabel.font = UIFont(name: "Inter-Regular", size: 16)
        tryToCorrectLabel.textColor = UIColor(named: "customBlack")
        tryToCorrectLabel.contentMode = .scaleAspectFit
        tryToCorrectLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        addSubview(loupe)
        loupe.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        addSubview(searchErrorLabel)
        searchErrorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loupe.snp.bottom).offset(8)
        }
        
        addSubview(tryToCorrectLabel)
        tryToCorrectLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(searchErrorLabel.snp.bottom).offset(12)
        }
    }
}
