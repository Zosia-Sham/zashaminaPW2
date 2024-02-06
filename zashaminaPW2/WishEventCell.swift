import UIKit

private enum Constants {
    static let titleLabelOffset: CGFloat = 8
    
    static let cornerRadius: CGFloat = 10
    
    static let fontSize: CGFloat = 16
    static let dateFontSize: CGFloat = 8
}

struct WishEventModel {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
}

class WishEventCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = .systemRed
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelOffset),
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelOffset),
            wrapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.titleLabelOffset),
            wrapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.titleLabelOffset)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.titleLabelOffset),
            titleLabel.topAnchor.constraint(equalTo: wrapView.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelOffset)
        ])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.titleLabelOffset),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleLabelOffset)
        ])
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = .black
        startDateLabel.font = UIFont.systemFont(ofSize: Constants.dateFontSize)
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.titleLabelOffset),
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.titleLabelOffset)
        ])
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = .black
        endDateLabel.font = UIFont.systemFont(ofSize: Constants.dateFontSize)
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            endDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.titleLabelOffset),
            endDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.titleLabelOffset)
        ])
    }
}
