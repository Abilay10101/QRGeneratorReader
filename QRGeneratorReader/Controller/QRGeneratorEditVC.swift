//
//  QRGeneratorEditVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 05.09.2022.
//

import UIKit
import EFQRCode
import CoreData

class QRGeneratorEditVC: UIViewController {
    
    var textForQR = ""
    var qrData: QRDataMO!
    var img = UIImage()
    var claimImage : UIImage?
    
    var initialTextLenght = 0
    var secTextLenght = 0
    var flagForChangeText = true

    @IBOutlet weak var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genOrPlace()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
    }
    
    func genOrPlace () {
        if claimImage != nil && flagForChangeText == true {
            qrImageView.image = claimImage
            img = claimImage!
        } else { createQR() }
    }
    
    func createQR () {
        let generator = EFQRCodeGenerator(content: textForQR)
        qrImageView.image = UIImage(cgImage: generator.generate()!)
        claimImage = UIImage(cgImage: generator.generate()!)
        img = UIImage(cgImage: generator.generate()!)
    }
    
    var imgArr = [UIImage]()
    var textArr = [String]()
    
    @IBAction func doneButton(_ sender: Any) {
        
        /*imgArr.append(img)
        textArr.append(textForQR)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genTableVC = storyboard.instantiateViewController(identifier: "TableGEN") as? GenerateTableVC {
            show(genTableVC, sender: nil)
        }*/
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            qrData = QRDataMO(context: appDelegate.persistentContainer.viewContext)
            qrData.qrInfo = textForQR
            qrData.qrType = "Text"
            qrData.qrImg = img.pngData()
            
            print("djskdjsaldjlkasdkasljaddklajdklsask")
            appDelegate.saveContext()
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genTableVC = storyboard.instantiateViewController(identifier: "TableGEN") as? GenerateTableVC {
            show(genTableVC, sender: nil)
        }
        
        //popToRootViewController(animated: true)
        
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [claimImage!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Успешно!")
            }
        }
        present(shareController, animated: true, completion: nil)
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
            let generator = EFQRCodeGenerator(content: textForQR)
            qrImageView.image = UIImage(cgImage: generator.generate()!)
            claimImage = UIImage(cgImage: generator.generate()!)
            img = UIImage(cgImage: generator.generate()!)
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
