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
        let systemSoundId: SystemSoundID = 1313
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    static func playCustomSound(name: String, ext: String) {
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: name, withExtension: ext) {

            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
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

