//
//  SaveTestTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 04.09.2022.
//

import UIKit

class SaveTestTableVC: UITableViewController {
    
    var emogi = Emogi(emogi: "", name: "", descriptions: "")
    
    @IBOutlet weak var emogiText: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        ubdateButtonState()
    }
    
    private func ubdateButtonState(){
        let emojiText = emogiText.text ?? ""
        let nameText = nameLabel.text ?? ""
        let descriptionText = descriptionLabel.text ?? ""
        
        saveButtonOutlet.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    private func updateUI(){
        emogiText.text = emogi.emogi
        nameLabel.text = emogi.name
        descriptionLabel.text = emogi.descriptions
    }
    
    @IBAction func textChanged(_ sender: Any) {
        ubdateButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return }
        
        let emogi = emogiText.text ?? ""
        let name = nameLabel.text ?? ""
        let description = descriptionLabel.text ?? ""
        
        self.emogi = Emogi(emogi: emogi, name: name, descriptions: description)
    }
    

}
