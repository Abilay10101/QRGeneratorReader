//
//  GenerateTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 03.09.2022.
//

import UIKit

class GenerateTableVC: UITableViewController {
    
    var objects = [
        QRData(qrImg: UIImage(named: "qr1")!, qrType: "Text", qrInfo: "dkslafdjl"),
        QRData(qrImg: UIImage(named: "qr2")!, qrType: "Text", qrInfo: "akfhdahff")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "QR Generator"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: - IBAction segue
    /*
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! SaveTestTableVC
        let emogi = sourceVC.emogi
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emogi
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emogi)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    */
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emogi = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! SaveTestTableVC
        newEmojiVC.emogi = emogi
        newEmojiVC.title = "Edit"
    }
     */
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenerateCell", for: indexPath) as! GenerateTableViewCell

        let object = objects[indexPath.row]
        cell.set(object: object)

        return cell
    }
    
    //MARK: - Delete and Move objects
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete ) {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let moveEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(moveEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
}
