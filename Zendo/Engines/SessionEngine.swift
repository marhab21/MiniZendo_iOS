//
//  SessionEngine.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import Foundation

let SESSIONS_KEY = "sessions"

enum UserAlertType {
    case delete
    case edit
    case skip
    case error
    case none
}

class SessionEngine {
    
    // This class is a singleton
    class var sharedInstance : SessionEngine {
        struct Static {
            static let instance: SessionEngine = SessionEngine()
        }
        return Static.instance
    }
    
    func allItems() -> [Session] {
        
        let sessionDictionary = UserDefaults.standard.dictionary(forKey: SESSIONS_KEY) ?? [:]
        let items = Array(sessionDictionary.values)
        
        return items.map({Session(durationInSeconds:($0 as! NSObject).value(forKey:"duration") as! Int, UUID: ($0 as! NSObject).value(forKey:"UUID") as! String)}).sorted(by: < )
         //   NSObject).value(forKey:"UUID") as! String)}).sorted(by: {(left: Session, right:Session) -> Bool in
               // (left.durationInSeconds < right.durationInSeconds) == .orderedAscending)
      //  })
    }
    
    func addItem(_ item: Session) {
        
        // persist this session in UserDefaults
        var sessionDictionary = UserDefaults.standard.dictionary(forKey: SESSIONS_KEY) ?? Dictionary()
        sessionDictionary[item.UUID] = ["duration": item.durationInSeconds, "UUID": item.UUID]
        
        UserDefaults.standard.set(sessionDictionary, forKey: SESSIONS_KEY) // save/overwrite todo item list
    }
    
    // Delete a task in both the list and the notificatons
    func removeItem(_ item: Session, alertType: UserAlertType) {
        
        
        if alertType != UserAlertType.skip {
            // Show an alert if required
            Utility.showAppropriateAlert(alertType, session: item)
            if var sessions = UserDefaults.standard.dictionary(forKey: SESSIONS_KEY) {
                sessions.removeValue(forKey: item.UUID)
                UserDefaults.standard.set(sessions, forKey: SESSIONS_KEY) // save/overwrite todo item list
            }
        }
    }
    
   
}

