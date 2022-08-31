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
    private lazy var circleView = UIView()
    private lazy var ratingTitle = UILabel()
    
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
    
    private func createSegment(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: circleView.frame.midX + 10, y: circleView.frame.midY + 10),
                            radius: 25, startAngle: startAngle.toRadians(),
                            endAngle: endAngle.toRadians(), clockwise: true)
    }
    
    private func createCircle(startAngle: CGFloat, endAngle: CGFloat) {
        let segmentPath = createSegment(startAngle: startAngle, endAngle: endAngle)
        let segmentLayer = CAShapeLayer()

        segmentLayer.path = segmentPath.cgPath
        segmentLayer.lineWidth = 6
        segmentLayer.strokeColor = UIColor.green.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        addAnimation(to: segmentLayer)
//        addGradientLayer(to: segmentLayer)
        circleView.layer.addSublayer(segmentLayer)

        
    }
    
    private func addAnimation(to layer: CALayer) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 0.75
        drawAnimation.repeatCount = 1.0
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        layer.add(drawAnimation, forKey: "drawCircleAnimation")
    }
    
//    private func addGradientLayer(to layer: CALayer) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.mask = layer
//        gradientLayer.frame = self.frame
//        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
//
//        self.layer.addSublayer(gradientLayer)
//    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        contentStack.axis = .vertical
        contentStack.distribution = .fillEqually
        
        filmPoster.layer.cornerRadius = 5
        filmPoster.backgroundColor = .black
        filmPoster.contentMode = .scaleToFill
        filmPoster.clipsToBounds = true
        
        filmTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        filmDescription.numberOfLines = 0
        filmDescription.lineBreakMode = .byWordWrapping
        filmDescription.minimumScaleFactor = 0.5
        

        ratingTitle.textColor = .white
        ratingTitle.tintColor = .white
        ratingTitle.text = "8,9"
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(filmPoster)
        filmPoster.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.height.equalTo(190)
            $0.width.equalTo(160)
        }
        
        filmPoster.addSubview(circleView)
        circleView.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(3)
            $0.height.width.equalTo(40)
        }
        
        circleView.addSubview(ratingTitle)
        ratingTitle.snp.makeConstraints {
            $0.top.left.equalToSuperview()
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
        ratingTitle.text = String(model.voteAverage)
        createCircle(startAngle: 0, endAngle: CGFloat(model.voteAverage))
        DispatchQueue.global().async {
            let url = "https://image.tmdb.org/t/p/w185\(model.posterPath)"
            guard let imageUrl = URL(string: url) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.filmPoster.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 5
    }
}
