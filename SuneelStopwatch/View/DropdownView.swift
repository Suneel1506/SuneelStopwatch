import UIKit

class DropdownView: UIView {
    
    // MARK: - Private Properties
    
    private let options: [String]
    private let tableView = UITableView()
    
    // MARK: - Public Properties
    
    var didSelectOption: ((String) -> Void)?
    
    // MARK: - Initialization
    
    init(options: [String]) {
        self.options = options
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // Styling
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8
    }
}
// MARK: - UITableViewDataSource

extension DropdownView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
// MARK: - UITableViewDelegate

extension DropdownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        didSelectOption?(selectedOption)
    }
}
