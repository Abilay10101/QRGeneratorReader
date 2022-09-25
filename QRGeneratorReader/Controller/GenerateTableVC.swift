//
//  GenerateTableVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 03.09.2022.
//

import UIKit
import CoreData

class GenerateTableVC: UITableViewController , NSFetchedResultsControllerDelegate {
    
    var fetchResultController: NSFetchedResultsController<QRDataMO>!
    
    var objects = [QRDataMO]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "QR Generator"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let fetchRequest: NSFetchRequest<QRDataMO> = QRDataMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "qrInfo", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    objects = fetchedObjects
                }
            } catch { print(error) }
        }
    }
    
    //MARK: - Work with segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "preview" else { return }
        let navigationVC = segue.destination as! PreviewVC
        let indexPath = tableView.indexPathForSelectedRow!
        let qrObj = objects[indexPath.row]
        navigationVC.text = qrObj.qrInfo!
        navigationVC.img = UIImage(data: qrObj.qrImg!)!
    }
    
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
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let objForDelete = objects[indexPath.row]
                
                context.delete(objForDelete)
                appDelegate.saveContext()
            }
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            let moveEmoji = objects.remove(at: sourceIndexPath.row)
            
            context.delete(moveEmoji)
            appDelegate.saveContext()
            
            objects.insert(moveEmoji, at: destinationIndexPath.row)
            tableView.reloadData()
        }
        
    }
    
}
