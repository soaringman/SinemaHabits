import UIKit
import SnapKit

class ErrorView: UIView {
    
    private lazy var NLOImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    lazy var tryAgainButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        NLOImageView.image = UIImage(named: "NLO")
        NLOImageView.clipsToBounds = true
        NLOImageView.layer.borderWidth = 0
        
        titleLabel.text = "Какой-то сверхразум всё сломал"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = UIColor(red: 0.05, green: 0.05, blue: 0.16, alpha: 1)
        
        subTitleLabel.text = "Постараемся быстро починить"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.textColor = UIColor(red: 151/255, green: 151/255, blue: 155/255, alpha: 1)
        
        tryAgainButton.backgroundColor = .clear
        tryAgainButton.setTitle("Попробовать снова", for: .normal)
        tryAgainButton.setTitleColor(.systemBlue, for: .normal)
        tryAgainButton.setTitle("Меня нажали", for: .highlighted)
        tryAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func setupConstraints() {
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
