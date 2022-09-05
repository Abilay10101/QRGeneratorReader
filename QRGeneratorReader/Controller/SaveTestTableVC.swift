//
//  SaveTestTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 04.09.2022.
//

import UIKit

class SaveTestTableVC: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generateButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ubdateButtonState()
    }
    
    private func ubdateButtonState(){
        let textField = textField.text ?? ""
        
        generateButton.isEnabled = !textField.isEmpty
    }
    
    @IBAction func textChanged(_ sender: Any) {
        ubdateButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "jerkMyAss" else { return }
        let navigationVC = segue.destination as! QRGeneratorEditVC
        let textField = textField.text!
        navigationVC.textForQR = textField
    }
    
    

}
