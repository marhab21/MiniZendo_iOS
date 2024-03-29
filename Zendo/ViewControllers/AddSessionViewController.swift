//
//  NewSessionViewController.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var timeSetter: UIDatePicker!
    
    @IBOutlet weak var saveStartButton: UIButton!
    
    var sessionSaved = false
    var sessionList: [Session] = []
    
    
    @IBAction func saveStartPressed(_ sender: UIButton) {
        
        for session in sessionList {
            if (Double(session.durationInSeconds) == Double(timeSetter.countDownDuration) ) {
                Utility.showAlertBox(AlertMessages.duplicateTime, msg: AlertMessages.noSession, view: self)
                sessionSaved = true
            }
        }
        
        if (sessionSaved == false) {
            
            let duration = timeSetter.countDownDuration
            
            if (sessionList.count <= 10) {
                let session = Session(durationInSeconds: Int(duration), UUID: UUID().uuidString)
                SessionEngine.sharedInstance.addItem(session)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "listShouldRefresh"), object: self)
                goBackToList()
            }
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

       timeSetter.datePickerMode = UIDatePicker.Mode.countDownTimer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        if let date = dateFormatter.date(from: "0:10") {
            timeSetter.date = date
        }
        
        timeSetter.stylizeView()
        timeSetter.backgroundColor = UIColor.lightGray
        
       sessionList = SessionEngine.sharedInstance.allItems()
       self.backView.backgroundColor = UIColor(netHex: 0xCBCAB7)
        
    }

    
    @objc func goBackToList() {
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: true)
    }

}

extension UIDatePicker {
    
    func stylizeView(view: UIView? = nil) {
        let view = view ?? self
        for subview in view.subviews {
            if let label = subview as? UILabel {
                if let text = label.text {
                    print("UIDatePicker :: sylizeLabel :: \(text)\n")
                    label.font = UIFont(name: "Arial", size: 18)
                }
            } else { stylizeView(view: subview) }
        }
    }}
