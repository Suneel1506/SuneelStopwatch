import UIKit

final class StopwatchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let stopwatchView = StopwatchView()
    private let viewModel = StopwatchViewModel()
    
    private var dropdownView: DropdownView?
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        view = stopwatchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupActions()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        viewModel.updateTimeLabel = { [weak self] timeText in
            self?.stopwatchView.timeLabel.text = timeText
        }
        
        viewModel.updateButtonTitle = { [weak self] buttonTitle in
            self?.stopwatchView.startPauseButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private func setupActions() {
        stopwatchView.startPauseButton.addTarget(self, action: #selector(startPauseTapped), for: .touchUpInside)
        stopwatchView.resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        stopwatchView.precisionDropdown.addTarget(self, action: #selector(precisionTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Handlers
    
    @objc private func startPauseTapped() {
        viewModel.startPauseTapped()
    }
    
    @objc private func resetTapped() {
        viewModel.resetTapped()
    }
    
    @objc private func precisionTapped() {
        if dropdownView == nil {
            showDropdown()
        } else {
            hideDropdown()
        }
    }
    
    // MARK: - Dropdown Methods
    
    private func showDropdown() {
        let options = [StopwatchViewModel.Precision.seconds.rawValue, StopwatchViewModel.Precision.milliseconds.rawValue]
        let dropdown = DropdownView(options: options)
        dropdown.didSelectOption = { [weak self] selectedOption in
            self?.viewModel.setPrecision(StopwatchViewModel.Precision(rawValue: selectedOption)!)
            self?.stopwatchView.precisionDropdown.setTitle(selectedOption, for: .normal)
            self?.hideDropdown()
        }
        dropdownView = dropdown
        
        view.addSubview(dropdown)
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropdown.leadingAnchor.constraint(equalTo: stopwatchView.precisionDropdown.leadingAnchor),
            dropdown.trailingAnchor.constraint(equalTo: stopwatchView.precisionDropdown.trailingAnchor),
            dropdown.topAnchor.constraint(equalTo: stopwatchView.precisionDropdown.bottomAnchor, constant: 10),
            dropdown.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func hideDropdown() {
        dropdownView?.removeFromSuperview()
        dropdownView = nil
    }
}
