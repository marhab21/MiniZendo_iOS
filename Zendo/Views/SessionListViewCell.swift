//
//  SessionListViewCell.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit

class SessionListViewCell: UITableViewCell {
    
    @IBOutlet weak var zenImage: UIImageView!
    @IBOutlet weak var sessionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    self.zenImage?.highlightedImage = UIImage(named: "zen.png")
    self.contentView.backgroundColor = UIColor(netHex: 0xCBCAB7)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

// This allows us to pick a custom color
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
            var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
            switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }
            case 6: break
            default: return nil
            }
            self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                    green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                     blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                    alpha: alpha)
        }
}
