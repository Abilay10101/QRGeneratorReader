//
//  PreviewVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 25.09.2022.
//

import UIKit

class PreviewVC: UIViewController {
    
    var text = ""
    var img = UIImage()
    
    @IBOutlet weak var qrTextLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var qrOpenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qrTextLabel.text = text
        qrImageView.image = img
        
        if let url = URL(string: text) {
            qrOpenButton.isEnabled = true
            qrOpenButton.isHidden = false
        } else {
            qrOpenButton.isEnabled = false
            qrOpenButton.isHidden = true
        }
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Успешно!")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func openLink(_ sender: UIButton) {
        if let url = URL(string: text) {
            UIApplication.shared.open(url)
        }
    }
    
}
