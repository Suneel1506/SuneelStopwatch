import UIKit

class StopwatchView: UIView {
    
    // MARK: - UI Components
    
  let precisionDropdown: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SECONDS", for: .normal)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let chevronImageView: UIImageView = {
        let chevronConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)
        let dropDownImage = UIImage(systemName: "chevron.down", withConfiguration: chevronConfig)
        let dropdownImageView = UIImageView(image: dropDownImage)
        dropdownImageView.contentMode = .scaleAspectFit
        dropdownImageView.tintColor = .black
        dropdownImageView.isUserInteractionEnabled = false
        dropdownImageView.translatesAutoresizingMaskIntoConstraints = false
        return dropdownImageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(precisionDropdown)
        precisionDropdown.addSubview(chevronImageView)
        addSubview(timeLabel)
        addSubview(startPauseButton)
        addSubview(resetButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            precisionDropdown.centerXAnchor.constraint(equalTo: centerXAnchor),
            precisionDropdown.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            precisionDropdown.widthAnchor.constraint(equalToConstant: 200),
            precisionDropdown.heightAnchor.constraint(equalToConstant: 50),
            
            chevronImageView.trailingAnchor.constraint(equalTo: precisionDropdown.trailingAnchor, constant: -10),
            chevronImageView.centerYAnchor.constraint(equalTo: precisionDropdown.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 15),
            chevronImageView.heightAnchor.constraint(equalToConstant: 15),
            
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: precisionDropdown.bottomAnchor, constant: 40),
            timeLabel.widthAnchor.constraint(equalToConstant: 260),
            timeLabel.heightAnchor.constraint(equalToConstant: 80),
            
            startPauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startPauseButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40),
            startPauseButton.heightAnchor.constraint(equalToConstant: 50),
            startPauseButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            
            resetButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            resetButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
