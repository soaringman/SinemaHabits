import UIKit
import SnapKit

class MainScreenCell: UITableViewCell {
    
    // ReuseID
    static let reuseID = "Cell"
    
    // MARK: - UI elements
    
    public lazy var filmDescription = UILabel()
    public lazy var filmPoster = UIImageView()
    
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
        filmPoster.layer.cornerRadius = 15
        filmPoster.backgroundColor = .cyan
        
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        
//        contentView.addSubview(filmDescription)
//        filmDescription.snp.makeConstraints {
//            $0.right.equalToSuperview().inset(16)
//        }
        
        contentView.addSubview(filmPoster)
        filmPoster.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(130)
        }
        
    }
    
}
