import UIKit

enum Constants {
    static let red: String = "Red"
    static let green: String = "Green"
    static let blue: String = "Blue"
    static let title: String = "WishMaker"
    static let description: String = "Hello. This is the WISH MAKER app.\nThe first wish is to change the background color.\nThe second one is to store wishes to grant later."
    static let hideButtonTitle: String = "hide/show sliders"
    static let addWishButtonTitle: String = "my wishes"
    
    static let sliderMin: Double = 0
    static let sliderMax: Double = 1
    
    static let sliderTop: CGFloat = 10
    static let sliderBottom: CGFloat = -10
    static let sliderLeading: CGFloat = 20
    
    static let stackRadius: CGFloat = 20
    static let stackBottom: CGFloat = -50
    static let stackLeading: CGFloat = 20
    
    static let titleTop: CGFloat = 50
    static let titleLeading: CGFloat = 20
    
    static let descriptionTop: CGFloat = 102
    static let descriptionLeading: CGFloat = 20
    
    static let buttonBottom: CGFloat = -50
    static let buttonWidth: Double = 0.4
    
    static let titleFontSize: CGFloat = 32
    static let descriptionFontSize: CGFloat = 16
    
    static let cornerRadius: CGFloat = 10
    
    static let zero: Int = 0
}

final class CustomSlider: UIView {
    var slider = UISlider()
    var titleView = UILabel()
    var valueChanged: ((Double) -> Void)?
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sliderTop ),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

final class WishMakerViewController: UIViewController {
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    private let stack = UIStackView()
    private let hideButton: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemPink
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureHideButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.title
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textAlignment = .center
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.description
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textAlignment = .center
        descriptionView.numberOfLines = Constants.zero
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLeading),
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.descriptionTop)
        ])
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.stackBottom),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            guard let components = self?.view.backgroundColor?.cgColor.components else { return }
            self?.view.backgroundColor = UIColor(red: value, green: components[1],
                                                 blue: components[2], alpha: components[3])
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            guard let components = self?.view.backgroundColor?.cgColor.components else { return }
            self?.view.backgroundColor = UIColor(red: components[0], green: value,
                                                 blue: components[2], alpha: components[3])
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            guard let components = self?.view.backgroundColor?.cgColor.components else { return }
            self?.view.backgroundColor = UIColor(red: components[0], green: components[1],
                                                 blue: value, alpha: components[3])
        }
    }
    
    private func configureHideButton() {
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.backgroundColor = .systemGray
        hideButton.setTitle(Constants.hideButtonTitle, for: .normal)
        hideButton.layer.cornerRadius = Constants.cornerRadius
        hideButton.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        
        view.addSubview(hideButton)
        NSLayoutConstraint.activate([
            hideButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidth),
            hideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideButton.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: Constants.buttonBottom)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.backgroundColor = .systemGray
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.layer.cornerRadius = Constants.cornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(addWishButton)
        NSLayoutConstraint.activate([
            addWishButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidth),
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonBottom)
        ])
    }
    
    @objc
    private func hideButtonPressed(sender: UIButton!) {
        stack.isHidden = !stack.isHidden
    }
    
    @objc
    private func addWishButtonPressed(sender: UIButton!) {
        present(WishStoringViewController(), animated: true)
    }
}
