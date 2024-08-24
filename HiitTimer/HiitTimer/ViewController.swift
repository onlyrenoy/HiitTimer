//
//  ViewController.swift
//  HiitTimer
//
//  Created by Renoy Chowdhury on 24/08/24.
//

import UIKit

class ViewController: UIViewController {

    var mainTimerLayer: CAShapeLayer!
    var pauseTimerLayer: CAShapeLayer!
    var timerLabel: UILabel!
    var startButton: UIButton!
    
    var mainTimerDuration: TimeInterval = 5 // In seconds, set to 1 minute
    var pauseTimerDuration: TimeInterval = 5 // In seconds, set to 30 seconds
    
    var mainTimer: Timer = Timer()
    var mainCounting = false
    
    var pauseTimer: Timer = Timer()
    var pauseCounting = false

    var remainingTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupMainTimerLayer()
        setupPauseTimerLayer()

        setupTimerLabel()
        setupStartButton()
    }
    
    func setupMainTimerLayer() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        mainTimerLayer = CAShapeLayer()
        mainTimerLayer.path = circularPath.cgPath
        mainTimerLayer.strokeColor = UIColor.orange.cgColor
        mainTimerLayer.lineWidth = 10
        mainTimerLayer.fillColor = UIColor.clear.cgColor
        mainTimerLayer.lineCap = .round
        mainTimerLayer.strokeEnd = 0
        
        view.layer.addSublayer(mainTimerLayer)
    }
    
    func setupPauseTimerLayer() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 90, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        pauseTimerLayer = CAShapeLayer()
        pauseTimerLayer.path = circularPath.cgPath
        pauseTimerLayer.strokeColor = UIColor.blue.cgColor
        pauseTimerLayer.lineWidth = 8
        pauseTimerLayer.fillColor = UIColor.clear.cgColor
        pauseTimerLayer.lineCap = .round
        pauseTimerLayer.strokeEnd = 0
        
        view.layer.addSublayer(pauseTimerLayer)
    }
    
    func setupTimerLabel() {
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        timerLabel.center = view.center
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 32)
        timerLabel.textColor = UIColor.black
        timerLabel.text = "0"
        view.addSubview(timerLabel)
    }
//    
    func setupStartButton() {
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.systemBlue
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        view.addSubview(startButton)
    }
//    
    @objc func startButtonTapped() {
        remainingTime = mainTimerDuration
        
        if mainCounting {
            mainCounting = false
            mainTimer.invalidate()
            startButton.setTitle("Start", for: .normal)
            
            mainTimerLayer.strokeEnd = 0
            pauseTimerLayer.strokeEnd = 0
            
        } else {
            mainCounting = true
            startButton.setTitle("stop", for: .normal)
            mainTimer = Timer.scheduledTimer(timeInterval: mainTimerDuration / 100, target: self, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
        }
//        startMainTimer()
    }
    
    
//
    func startMainTimer() {
        remainingTime = mainTimerDuration
        mainTimerLayer.strokeEnd = 0
//        startTimer(duration: mainTimerDuration, selector: #selector(updateMainTimer))
    }
//    
//    func startPauseTimer() {
//        remainingTime = pauseTimerDuration
//        pauseTimerLayer.strokeEnd = 0
//        startTimer(duration: pauseTimerDuration, selector: #selector(updatePauseTimer))
//    }
//    
//    func startTimer(duration: TimeInterval, selector: Selector) {
//        mainTimer.invalidate()
////        pauseTimer?.invalidate()
//        
//        Timer.scheduledTimer(timeInterval: duration / 100, target: self, selector: selector, userInfo: nil, repeats: true)
//    }
//    
    @objc func updateMainTimer() {
        if remainingTime > 0 {
            remainingTime -= mainTimerDuration / 100
            let progress = (mainTimerDuration - remainingTime) / mainTimerDuration
            mainTimerLayer.strokeEnd = CGFloat(progress)
            timerLabel.text = "\(Int(remainingTime))"
        } else {
            mainTimer.invalidate()
            if mainTimerLayer.strokeEnd >= 1  {
                remainingTime = pauseTimerDuration
              pauseTimer = Timer.scheduledTimer(timeInterval: pauseTimerDuration / 100, target: self, selector: #selector(updatePauseTimer), userInfo: nil, repeats: true)
            }
//            startPauseTimer()
        }
    }
//    
    @objc func updatePauseTimer() {
        if remainingTime > 0 {
            remainingTime -= pauseTimerDuration / 100
            let progress = (pauseTimerDuration - remainingTime) / pauseTimerDuration
            pauseTimerLayer.strokeEnd = CGFloat(progress)
            timerLabel.text = "\(Int(remainingTime))"
        } else {
            pauseTimer.invalidate()
        }
    }
//    
//    func resetTimers() {
//        // Reset the UI and timers
//        mainTimerLayer.strokeEnd = 0
//        pauseTimerLayer.strokeEnd = 0
//        timerLabel.text = "0"
//        startButton.isEnabled = true
//    }
}
