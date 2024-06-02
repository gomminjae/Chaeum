import UIKit




class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupContent()
    }
    
    func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.cyan.withAlphaComponent(0.7).cgColor, UIColor.purple.withAlphaComponent(0.3).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        
        let circleView = UIView()
        circleView.frame = CGRect(x: -100, y: 0, width: 300, height: 300)
        circleView.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        circleView.layer.cornerRadius = 150
        circleView.layer.masksToBounds = true
        view.addSubview(circleView)
        
        let roundedRectView = UIView()
        roundedRectView.frame = CGRect(x: 100, y: 200, width: 500, height: 500)
        roundedRectView.layer.cornerRadius = 30
        roundedRectView.layer.masksToBounds = true
        let roundedGradientLayer = CAGradientLayer()
        roundedGradientLayer.colors = [UIColor.purple.withAlphaComponent(0.6).cgColor, UIColor.systemMint.withAlphaComponent(0.5).cgColor]
        roundedGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        roundedGradientLayer.endPoint = CGPoint(x: 0, y: 1)
        roundedGradientLayer.frame = roundedRectView.bounds
        roundedRectView.layer.addSublayer(roundedGradientLayer)
        roundedRectView.transform = CGAffineTransform(rotationAngle: 30 * .pi / 180)
        view.addSubview(roundedRectView)
        
        let largeCircleView = UIView()
        
        largeCircleView.frame = CGRect(x: 200, y: -200, width: 450, height: 450)
        largeCircleView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
        largeCircleView.layer.cornerRadius = 225
        largeCircleView.layer.masksToBounds = true
        view.addSubview(largeCircleView)
        
        // Adding blur effect to background elements
        addBlurEffect(view: view, radius: 20)
    }
    
    func setupContent() {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 50
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStackView)
        
        // Rank and Birthday info
        let infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.distribution = .fillEqually
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let rankView = createInfoView(value: "2", title: "rank")
        let birthdayView = createInfoView(value: "Nov 3", title: "birthday")
        let ageView = createInfoView(value: "26", title: "years old")
        
        infoStackView.addArrangedSubview(rankView)
        infoStackView.addArrangedSubview(birthdayView)
        infoStackView.addArrangedSubview(ageView)
        
        // Adding blur effect to infoStackView
        let infoBlurEffect = UIBlurEffect(style: .systemThinMaterial)
        let infoBlurView = UIVisualEffectView(effect: infoBlurEffect)
        infoBlurView.layer.cornerRadius = 12
        infoBlurView.layer.masksToBounds = true
        infoBlurView.contentView.addSubview(infoStackView)
        infoBlurView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(infoBlurView)
        
        // Communication info
        let communicationView = UIView()
        communicationView.translatesAutoresizingMaskIntoConstraints = false
        
        let commTitleLabel = UILabel()
        commTitleLabel.text = "COMMUNICATION"
        commTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        commTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = "yeah I tried to go yesterday but they were closed so maybe tomorrow idk"
        messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageLabel.numberOfLines = 2
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageDateLabel = UILabel()
        messageDateLabel.text = "yesterday"
        messageDateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        messageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageStackView = UIStackView(arrangedSubviews: [messageLabel, messageDateLabel])
        messageStackView.axis = .horizontal
        messageStackView.spacing = 20
        messageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let communicationDataStackView = UIStackView()
        communicationDataStackView.axis = .horizontal
        communicationDataStackView.distribution = .fillEqually
        communicationDataStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let avgTextsView = createInfoView(value: "4.3", title: "avg texts / day")
        let thisMonthView = createInfoView(value: "+19%", title: "this month", valueColor: .green)
        let lastSpokeView = createInfoView(value: "12 hrs", title: "last spoke")
        
        communicationDataStackView.addArrangedSubview(avgTextsView)
        communicationDataStackView.addArrangedSubview(thisMonthView)
        communicationDataStackView.addArrangedSubview(lastSpokeView)
        
        communicationView.addSubview(commTitleLabel)
        communicationView.addSubview(messageStackView)
        communicationView.addSubview(communicationDataStackView)
        
        NSLayoutConstraint.activate([
            commTitleLabel.topAnchor.constraint(equalTo: communicationView.topAnchor, constant: 16),
            commTitleLabel.leadingAnchor.constraint(equalTo: communicationView.leadingAnchor, constant: 16),
            
            messageStackView.topAnchor.constraint(equalTo: commTitleLabel.bottomAnchor, constant: 8),
            messageStackView.leadingAnchor.constraint(equalTo: communicationView.leadingAnchor, constant: 16),
            messageStackView.trailingAnchor.constraint(equalTo: communicationView.trailingAnchor, constant: -16),
            
            communicationDataStackView.topAnchor.constraint(equalTo: messageStackView.bottomAnchor, constant: 16),
            communicationDataStackView.leadingAnchor.constraint(equalTo: communicationView.leadingAnchor, constant: 16),
            communicationDataStackView.trailingAnchor.constraint(equalTo: communicationView.trailingAnchor, constant: -16),
            communicationDataStackView.bottomAnchor.constraint(equalTo: communicationView.bottomAnchor, constant: -16)
        ])
        
        // Adding blur effect to communicationView
        let communicationBlurEffect = UIBlurEffect(style: .systemThinMaterial)
        let communicationBlurView = UIVisualEffectView(effect: communicationBlurEffect)
        communicationBlurView.layer.cornerRadius = 20
        communicationBlurView.layer.masksToBounds = true
        communicationBlurView.contentView.addSubview(communicationView)
        communicationBlurView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(communicationBlurView)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.widthAnchor.constraint(equalToConstant: 360),
            infoBlurView.heightAnchor.constraint(equalToConstant: 100),
            communicationBlurView.heightAnchor.constraint(equalToConstant: 200),
            
            infoStackView.topAnchor.constraint(equalTo: infoBlurView.contentView.topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: infoBlurView.contentView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: infoBlurView.contentView.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: infoBlurView.contentView.bottomAnchor),
            
            communicationView.topAnchor.constraint(equalTo: communicationBlurView.contentView.topAnchor),
            communicationView.leadingAnchor.constraint(equalTo: communicationBlurView.contentView.leadingAnchor),
            communicationView.trailingAnchor.constraint(equalTo: communicationBlurView.contentView.trailingAnchor),
            communicationView.bottomAnchor.constraint(equalTo: communicationBlurView.contentView.bottomAnchor)
        ])
    }
    
    func createInfoView(value: String, title: String, valueColor: UIColor = .label) -> UIView {
        let view = UIView()
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = valueColor
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func addBlurEffect(view: UIView, radius: CGFloat) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
