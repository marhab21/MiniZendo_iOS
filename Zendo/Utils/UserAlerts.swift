//
//  UserAlerts.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//
import UIKit

enum AlertActionType {
    case moveToRoot
    case stay
    case moveToPage
}


// This class is mainly for generic alert boxes
class Utility {
    
    // This box doesn't require interaction from the user, except dismiss.
    static func showAlertBox(_ alert: String, msg: String, view: UIViewController, move: Bool = false) {
        
        let actionMsg = "OK"
        let moveOnAction = UIAlertAction(title: actionMsg, style: UIAlertActionStyle.default) {
            UIAlertAction in
            if move {
                let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
                navigationController.popToRootViewController(animated: true) // return to list view
            }
            
        }
        
        let alert = UIAlertController(title: alert, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(moveOnAction)
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    // This alert class requires action from the user.
    static func userReallyWantsThis(_ alert: String, msg: String, view: UIViewController, actionNO: UIAlertAction, actionOK: UIAlertAction){
        
        
        let refreshAlert = UIAlertController(title: alert, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(actionNO)
        refreshAlert.addAction(actionOK)
        
        
        view.present(refreshAlert, animated: true, completion: nil)
    }
    
    // Show the appropriate alert according to the type.
    static func showAppropriateAlert(_ alertType: UserAlertType, session: Session) {
        
        let myView = UIApplication.shared.windows[0].rootViewController
        var alertTitle = "Message" // Just placeholders
        var alertAction = "Action"
        
        switch(alertType) {
        case UserAlertType.delete:
            alertTitle = AlertMessages.sessionDeleted
            alertAction = AlertMessages.hasBeenDeleted
            Utility.showAlertBox(alertTitle, msg: AlertMessages.yourSession + " \"\(session.title)\" " + alertAction, view: myView!)
        case UserAlertType.error:
            alertTitle = AlertMessages.errorTitle
            Utility.showAlertBox(alertTitle, msg: AlertMessages.errorAlert, view: myView!)
        default:
            return
        }
    }
    
}
