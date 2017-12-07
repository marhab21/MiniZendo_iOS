//
//  SoundPlayer.swift
//  Zendo
//
//  Created by Martine Habib on 12/3/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import Foundation
import AudioToolbox


class SoundPlayer {
    
    static var customSoundId: SystemSoundID = 0
    
    static func playTestSound() {
        let systemSoundId: SystemSoundID = 1013
    //    AudioServicesPlaySystemSound(systemSoundId)
     //   systemSoundId = 1013
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    static func playCustomSound() {
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: "bell", withExtension: "mp3") {
      //      customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            //let systemSoundId: SystemSoundID = 1016  // to play apple's built in sound, no need for upper 3 lines
            
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            
            AudioServicesPlaySystemSound(customSoundId)
        }
    }
    
    static func deleteSound() {
        AudioServicesDisposeSystemSoundID(customSoundId)
    }
    
}

