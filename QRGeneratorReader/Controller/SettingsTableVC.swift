//
//  SettingsTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 19.09.2022.
//

import UIKit

class SettingsTableVC: UITableViewController {
    

    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibroSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults()
        if let data = userDefaults.object(forKey: "dataMata") {
            if let message = data as? Bool {
                if message {
                    soundSwitch.isOn = true
                } else {
                    soundSwitch.isOn = false
                }
            }
        }
        
        let userDefaults2 = UserDefaults()
        if let data = userDefaults2.object(forKey: "dataMatka") {
            if let message = data as? Bool {
                if message {
                    vibroSwitch.isOn = true
                } else {
                    vibroSwitch.isOn = false
                }
            }
        }
        
    }
    
    
    @IBAction func soundSwitchAction(_ sender: Any) {
        if soundSwitch.isOn {
            let userDefaults = UserDefaults()
            userDefaults.set(true, forKey: "dataMata")
        } else {
            let userDefaults = UserDefaults()
            userDefaults.set(false, forKey: "dataMata")
        }
    }
    
    @IBAction func vibroSwitchAction(_ sender: Any) {
        if vibroSwitch.isOn {
            let userDefaults2 = UserDefaults()
            userDefaults2.set(true, forKey: "dataMatka")
        } else {
            let userDefaults2 = UserDefaults()
            userDefaults2.set(false, forKey: "dataMatka")
        }
    }
    
    

}
