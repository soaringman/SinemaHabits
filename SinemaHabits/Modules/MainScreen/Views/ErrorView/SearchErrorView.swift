import UIKit

class SearchErrorView: UIView {
    
    private let loupe = UIImageView()
    private let searchErrorLabel = UILabel()
    private let tryToCorrectLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loupe)
        addSubview(searchErrorLabel)
        addSubview(tryToCorrectLabel)
        
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        loupe.image = UIImage(named: "loupe")
        
        searchErrorLabel.text = "Мы никого не нашли"
        searchErrorLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        searchErrorLabel.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        searchErrorLabel.contentMode = .scaleAspectFit
        searchErrorLabel.textAlignment = .center
        
        tryToCorrectLabel.text = "Попробуйте скорректировать запрос"
        tryToCorrectLabel.font = UIFont(name: "Inter-Regular", size: 16)
        tryToCorrectLabel.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        tryToCorrectLabel.contentMode = .scaleAspectFit
        tryToCorrectLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        loupe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loupe.centerXAnchor.constraint(equalTo: centerXAnchor),
            loupe.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            loupe.widthAnchor.constraint(equalToConstant: 56),
            loupe.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        searchErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchErrorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchErrorLabel.topAnchor.constraint(equalTo: loupe.bottomAnchor, constant: 8)
        ])
        
        tryToCorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryToCorrectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryToCorrectLabel.topAnchor.constraint(equalTo: searchErrorLabel.bottomAnchor, constant: 12)
        ])
    }
}
