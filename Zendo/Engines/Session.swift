//
//  Session.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import Foundation

class Session {
    
    var title = "Meditation"
    var durationInSeconds = 10
    var displayDuration = 0
    var UUID: String
    
    
    init(durationInSeconds: Int, UUID: String) {
        self.durationInSeconds = durationInSeconds
        displayDuration = durationInSeconds / 60
        
        self.UUID = UUID
        self.title = getTimeDisplay()
    }
    
    func getTimeDisplay() -> String {
        
        var hrText = "hour"
        var minText = "minutes"
        var totalText = ""
        
        let minutes = displayDuration
        
        let hours = minutes / 60
        let mins = minutes % 60
        // Formatting
        if (hours > 0) {
            if (hours > 1) {
                hrText = "hours"
            }
            totalText = "\(hours) \(hrText), "
        } else {
            totalText = ""
        }
        
        if (minutes == 1) {
            minText = "minute"
        }
        
        totalText += "\(mins) \(minText)"
        return totalText
    }
    
    
    // Adds a random message at the end of the session upon notification
    func addMessage() -> String {
        
        let total = Constants.msgGeneric.count
        let index = Int(arc4random_uniform(UInt32(total)))
        return Constants.msgGeneric[index]
    }
    
    
}

extension Session: Comparable {
    
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.durationInSeconds == rhs.durationInSeconds
    }
    
    static func < (lhs: Session, rhs: Session) -> Bool {
        return lhs.durationInSeconds < rhs.durationInSeconds
    }
}
