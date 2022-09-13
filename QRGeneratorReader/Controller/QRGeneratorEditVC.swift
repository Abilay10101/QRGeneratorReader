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
    var qrData = QRData(qrImg: UIImage(), qrType: "", qrInfo: "")
    var img = UIImage()
    var claimImage : UIImage?

    @IBOutlet weak var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genOrPlace()
    }
    
    func genOrPlace () {
        if claimImage != nil {
            qrImageView.image = claimImage
            img = claimImage!
        } else { createQR() }
    }
    
    func createQR () {
        if let image = EFQRCode.generate(
            for: textForQR
        ) {
            print("Create QRCode image success \(image)")
            qrImageView.image = UIImage(cgImage: image)
            img = UIImage(cgImage: image)
        } else { }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genTableVC = storyboard.instantiateViewController(identifier: "TableGEN") as? GenerateTableVC {
            genTableVC.objects.append(QRData(qrImg: img, qrType: "Text", qrInfo: textForQR))
            show(genTableVC, sender: nil)
        }
    }
    
    //MARK: - Work with Segue
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        if seg.identifier == "saveSegue" {
            guard seg.identifier == "saveSegue" else {return}
            let sourceVC = seg.source as! EditQRVC
            claimImage = sourceVC.imageForIV
            genOrPlace()
        }
        else {
            guard seg.identifier == "changeSegue" else {return}
            let sourceVC = seg.source as! EditTextTableVC
            textForQR = sourceVC.text
            genOrPlace()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "Editing" {
            guard segue.identifier == "Editing" else { return }
            let navigationVC = segue.destination as! UINavigationController
            let newVC = navigationVC.topViewController as! EditQRVC
            newVC.textForQr = self.textForQR
        }
        else {
            guard segue.identifier == "TextChange" else { return }
            let navigationVC = segue.destination as! UINavigationController
            let newVC = navigationVC.topViewController as! EditTextTableVC
            newVC.text = self.textForQR
        }
    }
    
    

}
