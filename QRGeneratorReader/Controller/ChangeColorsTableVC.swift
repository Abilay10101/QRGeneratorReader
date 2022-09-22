//
//  ChangeColorsTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 20.09.2022.
//

import UIKit

class ChangeColorsTableVC: UITableViewController {
    
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    @IBOutlet weak var graySwitch: UISwitch!
    @IBOutlet weak var indigoSwitch: UISwitch!
    @IBOutlet weak var tealSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueSwitch.setOn(true, animated: true)
        graySwitch.setOn(false, animated: true)
        indigoSwitch.setOn(false, animated: true)
        tealSwitch.setOn(false, animated: true)
        redSwitch.setOn(false, animated: true)
        
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        switch sender.tag {
        case 1:
            
            let userDefaults = UserDefaults()
            userDefaults.set("red", forKey: "changeColors")
            
            blueSwitch.setOn(false, animated: true)
            graySwitch.setOn(false, animated: true)
            indigoSwitch.setOn(false, animated: true)
            tealSwitch.setOn(false, animated: true)
        case 2:
            
            let userDefaults = UserDefaults()
            userDefaults.set("blue", forKey: "changeColors")
            
            redSwitch.setOn(false, animated: true)
            graySwitch.setOn(false, animated: true)
            indigoSwitch.setOn(false, animated: true)
            tealSwitch.setOn(false, animated: true)
        case 3:
            
            let userDefaults = UserDefaults()
            userDefaults.set("gray", forKey: "changeColors")
            
            blueSwitch.setOn(false, animated: true)
            redSwitch.setOn(false, animated: true)
            indigoSwitch.setOn(false, animated: true)
            tealSwitch.setOn(false, animated: true)
        case 4:
            
            let userDefaults = UserDefaults()
            userDefaults.set("indigo", forKey: "changeColors")
            
            blueSwitch.setOn(false, animated: true)
            graySwitch.setOn(false, animated: true)
            redSwitch.setOn(false, animated: true)
            tealSwitch.setOn(false, animated: true)
        case 5:
            
            let userDefaults = UserDefaults()
            userDefaults.set("teal", forKey: "changeColors")
            
            blueSwitch.setOn(false, animated: true)
            graySwitch.setOn(false, animated: true)
            indigoSwitch.setOn(false, animated: true)
            redSwitch.setOn(false, animated: true)
        default:
            break
        }
    }
    
    
    
}
