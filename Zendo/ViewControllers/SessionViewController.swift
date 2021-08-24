//
//  SessionViewController.swift
//  Zendo
//
//  Created by Martine Habib on 12/3/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit



class SessionViewController: UIViewController {
    
    
    @IBOutlet weak var quotedText: UITextView!
    
    var currentSession: Session?
    let notifCenter = NotificationCenter.default
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 60
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    var doneTimer = Timer()
    var formFactor = FormFactor()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Only if the current session has come through
        timeLeft = Double((currentSession?.durationInSeconds)!)
        
        formFactor = FormFactor.setDeviceType()
        notifCenter.addObserver(self, selector: #selector(self.killTimers), name: Notification.Name(rawValue: "earlyExit"), object: nil)
        // Make sure the phone doesn't lock while the app is running.
        UIApplication.shared.isIdleTimerDisabled = true
        
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()
        // here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
        // add the animation to your timeLeftShapeLayer
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
        // define the future end time by adding the timeLeft to now Date()
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        SoundPlayer.playCustomSound(name: "sms_alert_note", ext: "caf")
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
         timer.invalidate()
         doneTimer.invalidate()
    }
    
    func addTimeLabel() {
        
        timeLabel = UILabel(frame: CGRect(x: view.frame.midX + formFactor.labelX ,y: view.frame.midY + formFactor.labelY, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        view.addSubview(timeLabel)
    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX + formFactor.circleX , y: view.frame.midY + formFactor.circleY), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.black.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        view.layer.addSublayer(bgShapeLayer)
    }
    
    
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX + formFactor.circleX , y: view.frame.midY + formFactor.circleY), radius:
            50, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
      
        timeLeftShapeLayer.strokeColor = UIColor(netHex: 0x339966).cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 15
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            SoundPlayer.playCustomSound(name: "bell", ext: "mp3")
            
            quotedText.text = currentSession?.addMessage()
            timeLabel.text = "00:00"
            timer.invalidate()
            doneTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(moveOn), userInfo: nil, repeats: false)
        }
    }
    
     @objc func moveOn() {
        doneTimer.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: true)
    }
    
    @objc func killTimers() {
        updateTime()
        timer.invalidate()
        doneTimer.invalidate()
    }
    
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

