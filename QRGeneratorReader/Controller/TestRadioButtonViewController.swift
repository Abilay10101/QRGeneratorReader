//
//  TestRadioButtonViewController.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 07.09.2022.
//

import UIKit

class TestRadioButtonViewController: UIViewController {
    
    @IBOutlet var anothetButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        anothetButtons.forEach({ $0.tintColor = .blue })
        sender.tintColor = .red
        selectedButton()
    }
    
    func selectedButton() {
        for (index , button) in anothetButtons.enumerated() {
            if button.tintColor == .red {
                print(index)
            }
        }
    }
    
}
