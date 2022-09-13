//
//  EditTextTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 13.09.2022.
//

import UIKit

class EditTextTableVC: UITableViewController {
    
    @IBOutlet weak var changeTextPlaceholder: UITextField!
    @IBOutlet weak var changeButton: UIBarButtonItem!
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ubdateStateOfButton()
        changeTextPlaceholder.text = text
    }
    
    func ubdateStateOfButton () {
        let text = changeTextPlaceholder.text ?? ""
        changeButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        ubdateStateOfButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "changeSegue" else { return }
        text = changeTextPlaceholder.text!
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}
