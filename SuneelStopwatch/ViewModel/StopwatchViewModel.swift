import Foundation

class StopwatchViewModel {
    
    // MARK: - Enums
    
    enum Precision: String {
        case seconds = "SECONDS"
        case milliseconds = "MILLISECONDS"
    }
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0
    private(set) var precision: Precision = .seconds
    
    // MARK: - Public Properties
    
    var updateTimeLabel: ((String) -> Void)?
    var updateButtonTitle: ((String) -> Void)?
    
    // MARK: - Private Methods
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: precision == .seconds ? 1.0 : 0.01, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    private func pauseTimer() {
        if let startTime = startTime {
            elapsedTime += Date().timeIntervalSince(startTime)
        }
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0
        updateButtonTitle?("Start")
    }
    
    @objc private func timerTick() {
        let currentTime = elapsedTime + Date().timeIntervalSince(startTime ?? Date())
        updateTimeLabel?(formattedTime(from: currentTime))
    }
    
    // MARK: - Public Methods
    
    func startPauseTapped() {
        if timer == nil {
            startTimer()
            updateButtonTitle?("Pause")
        } else {
            pauseTimer()
            updateButtonTitle?("Start")
        }
    }
    
    func resetTapped() {
        resetTimer()
        updateTimeLabel?(formattedTime())
    }
    
    func setPrecision(_ precision: Precision) {
        self.precision = precision
        resetTimer()
        updateTimeLabel?(formattedTime())
    }
    
    // MARK: - Formatting
    
    private func formattedTime(from timeInterval: TimeInterval = 0) -> String {
        let totalSeconds = Int(timeInterval)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        let milliseconds = Int((timeInterval - Double(totalSeconds)) * 1000)
        
        switch precision {
        case .seconds:
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        case .milliseconds:
            return String(format: "%02d:%02d:%02d:%03d", hours, minutes, seconds, milliseconds)
        }
    }
}
