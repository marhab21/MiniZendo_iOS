//
//  HelpViewController.swift
//  Mini Zendo
//
//  Created by Martine Habib on 12/6/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    
    @IBOutlet weak var helpText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.helpText.backgroundColor = UIColor(netHex: 0xCBCAB7)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
