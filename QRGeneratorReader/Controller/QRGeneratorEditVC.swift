//
//  QRGeneratorEditVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 05.09.2022.
//

import UIKit
import EFQRCode

class QRGeneratorEditVC: UIViewController {
    
    var textForQR = ""
    var qrData = QRData(qrImg: UIImage(named: "qr1")!, qrType: "", qrInfo: "")
    var img = UIImage()

    @IBOutlet weak var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createQR()
    }
    
    func createQR () {
        if let image = EFQRCode.generate(
            for: textForQR
        ) {
            print("Create QRCode image success \(image)")
            qrImageView.image = UIImage(cgImage: image)
            img = UIImage(cgImage: image)
        } else {
            print("Create QRCode image failed!")
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genTableVC = storyboard.instantiateViewController(identifier: "TableGEN") as? GenerateTableVC {
            genTableVC.objects.append(QRData(qrImg: img, qrType: "Text", qrInfo: textForQR))
            show(genTableVC, sender: nil)
        }
        
        //self.navigationController?.popToRootViewController(animated: true)
    }
    

}
