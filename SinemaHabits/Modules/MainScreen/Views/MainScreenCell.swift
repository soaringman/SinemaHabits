import UIKit
import SnapKit
import CloudKit

final class MainScreenCell: UITableViewCell {
    
    // ReuseID
    static let reuseID = "Cell"
    private let mainScreenModel = MainScreenModel()
    
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
        prepareForReuse()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filmPoster.image = nil
        filmDescription.text = nil
        filmStartDate.text = nil
        filmTitle.text = nil
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        contentStack.axis = .vertical
        contentStack.distribution = .fillProportionally
        contentStack.spacing = 5
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 32
        circleView.layer.opacity = 0.7
        
        filmPoster.layer.cornerRadius = 10
        filmPoster.contentMode = .scaleToFill
        filmPoster.layer.masksToBounds = true
        filmPoster.layer.borderWidth = 0.2
        
        filmTitle.font = UIFont.boldSystemFont(ofSize: 17)
        
        filmDescription.numberOfLines = 7
        filmDescription.minimumScaleFactor = 0.1
        filmDescription.textColor = .gray
        filmDescription.font = UIFont.italicSystemFont(ofSize: 15)
        
        ratingTitle.textColor = .black
        ratingTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(filmPoster)
        filmPoster.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(10)
            $0.height.equalTo(190)
            $0.width.equalTo(140)
        }
        
        filmPoster.addSubview(circleView)
        circleView.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(3)
            $0.height.width.equalTo(64)
        }
        
        circleView.addSubview(ratingTitle)
        ratingTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.left.equalTo(filmPoster.snp.right).offset(10)
            $0.top.bottom.right.equalToSuperview().inset(10)
        }
    }
    
    private func createSegment(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: circleView.frame.midX + 32,
                                               y: circleView.frame.midY + 32),
                            radius: 25, startAngle: startAngle.toRadians(),
                            endAngle: endAngle.toRadians(), clockwise: true)
    }
    
    func createCircle(startAngle: CGFloat, endAngle: CGFloat) {
        let segmentPath = createSegment(startAngle: startAngle, endAngle: endAngle)
        let segmentLayer = CAShapeLayer()

        segmentLayer.path = segmentPath.cgPath
        segmentLayer.lineWidth = 6
        segmentLayer.strokeColor = UIColor.red.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        segmentLayer.opacity = 0.7
        addAnimation(to: segmentLayer)
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

    func setupCell(from model: FilmAndTVResult) {
        filmTitle.text = model.name
        filmDescription.text = model.overview
        guard let newDate = mainScreenModel.processDate(string: model.firstAirDate ?? "",
                                                        fromFormat: "yyyy-MM-dd",
                                                        toFormat: "dd.MM.yyyy") else {return}
        filmStartDate.text = "Start date: \(newDate)"
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
