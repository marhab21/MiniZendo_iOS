//
//  DeviceFinder.swift
//  Mini Zendo
//
//  Created by Martine Habib on 12/5/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit
// To help move the circle where it belongs
struct FormFactor {
    var labelX, labelY: CGFloat
    var circleX, circleY: CGFloat
    
    init() {
        labelX = 0
        labelY = 0
        circleX = 0
        circleY = 0
    }
    
    init (labX: CGFloat, labY: CGFloat, cirX: CGFloat, cirY: CGFloat) {
        labelX = labX
        labelY = labY
        circleX = cirX
        circleY = cirY
    }

    // Setting up the measurements for the circle.
    static func setDeviceType() -> FormFactor {
        
        var ff = FormFactor()
        
         switch UIDevice.current.modelName {
         case "iPhone 5":
            ff = FormFactor(labX: -130, labY: 195, cirX: -80, cirY: 220)
         case "iPhone 6,7,8":
            ff = FormFactor(labX: -130, labY: 195, cirX: -80, cirY: 220)
         case "iPhone SE":
            ff = FormFactor(labX: -130, labY: 195, cirX: -80, cirY: 220)
         case "iPhone Plus":
            ff = FormFactor(labX: -180, labY: 255, cirX: -130, cirY: 280)
         case "iPhone X":
            ff = FormFactor(labX: -170, labY: 255, cirX: -120, cirY: 280)
         case "Simulator":
            // iPhone 6 for simulator
              ff = FormFactor(labX: -130, labY: 195, cirX: -80, cirY: 220)
         default:
            if (UIDevice.current.modelName.contains("iPad")) {
                 ff = FormFactor(labX: -130, labY: 195, cirX: -80, cirY: 220)
            } else {
                print("Mini Zendo not available for this device")
            }
         }
        return ff
    }
}

// Guessing the device type
public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1":
            return "iPhone 4"
            
        case "iPhone8,4":
            return "iPhone SE"
            
        case "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2":
            return "iPhone 5"
            
        case "iPhone7,2", "iPhone8,1", "iPhone9,1", "iPhone9,3", "iPhone10,1", "iPhone10,4":
            return "iPhone 6,7,8"
            
        case "iPhone7,1", "iPhone8,2", "iPhone9,2", "iPhone9,4", "iPhone10,2", "iPhone10,5":
            return "iPhone Plus"
            
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
            
        case "i386", "x86_64":
            return "Simulator"
        default:
            if (identifier.contains("iPad")) {
                return "iPad"
            }
            return identifier
        }
    }
}
