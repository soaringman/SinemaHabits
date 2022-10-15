import UIKit
import SnapKit

final class ErrorView: UIView {
    
    // MARK: - UI Elements
    
    lazy var tryAgainButton = UIButton()
    
    private lazy var NLOImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension ErrorView {
    
    func setupUI() {
        backgroundColor = UIColor(named: "customWhite")
        
        NLOImageView.image = UIImage(named: "NLO")
        NLOImageView.clipsToBounds = true
        NLOImageView.layer.borderWidth = 0
        
        titleLabel.text = "Какой-то сверхразум всё сломал"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = UIColor(named: "customBlack")
        
        subTitleLabel.text = "Постараемся быстро починить"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.textColor = UIColor(named: "customBlack")
        
        tryAgainButton.backgroundColor = .clear
        tryAgainButton.setTitle("Попробовать снова", for: .normal)
        tryAgainButton.setTitleColor(.systemBlue, for: .normal)
        tryAgainButton.setTitle("Меня нажали", for: .highlighted)
        tryAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func setupConstraints() {
        addSubview(NLOImageView)
        NLOImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(NLOImageView.snp.bottom).offset(8)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        addSubview(tryAgainButton)
        tryAgainButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
        }
    }
}
