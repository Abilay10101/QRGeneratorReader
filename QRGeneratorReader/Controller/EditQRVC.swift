//
//  EditQRVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 11.09.2022.
//

import UIKit
import EFQRCode


class EditQRVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var markerPositions: [UIButton]!
    @IBOutlet var logoArr: [UIButton]!
    @IBOutlet var colorButtonArr: [UIButton]!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var imageForIV : UIImage?
    var textForQr = ""
    
    var selectedColor : UIColor?
    var selectedWatermark = UIImage()
    
    var flaggSquare = false
    var flaggCircle = false
    var flaggDiamond = false
    
    var circlePositionMarker = EFCirclePointStyle.circle
    var squarePositionMarker = EFSquarePointStyle.square
    var diamondPositionMarker = EFDiamondPointStyle.diamond
    
    var watermarks = UIImage(named: "song")?.cgImage
    var colors = "red"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createQR()
    }
    
    func createQR () {
        if let image = EFQRCode.generate(
            for: textForQr
        ) {
            print("Create QRCode image success \(image)")
            imageView.image = UIImage(cgImage: image)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        imageForIV = imageView.image
    }
    
    //MARK: - Marker Changer
    @IBAction func changeMarker(_ sender: UIButton) {
        if sender.tag == 1 {
            let generator = EFQRCodeGenerator(content: textForQr)
            flaggSquare = true
            flaggCircle = false
            flaggDiamond = false
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withPointStyle(squarePositionMarker)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
        else if sender.tag == 2 {
            let generator = EFQRCodeGenerator(content: textForQr)
            flaggSquare = false
            flaggCircle = true
            flaggDiamond = false
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withPointStyle(circlePositionMarker)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
        else {
            let generator = EFQRCodeGenerator(content: textForQr)
            flaggSquare = false
            flaggCircle = false
            flaggDiamond = true
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withPointStyle(diamondPositionMarker)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
    }
    
    //MARK: - Watermark Changer
    @IBAction func changeWatermark(_ sender: UIButton) {
        if sender.tag == 1 {
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedWatermark = UIImage(named: "wwifi")!
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withWatermark(UIImage(named: "wwifi")?.cgImage)
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
        else if sender.tag == 2 {
            print("AHAHHAHAHA")
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedWatermark = UIImage(named: "food")!
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withWatermark(UIImage(named: "food")?.cgImage)
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
        else if sender.tag == 3 {
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedWatermark = UIImage(named: "site")!
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            generator.withWatermark(UIImage(named: "site")?.cgImage)
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
        else if sender.tag == 4 {
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedWatermark = UIImage()
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: selectedColor?.cgColor ?? UIColor.black.cgColor)
            
            //generator.withWatermark(UIImage(named: "site")?.cgImage)
            imageView.image = UIImage(cgImage: generator.generate()!)
        }
    }
    
    //MARK: - Color Changer
    @IBAction func changeColors(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.yellow
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.yellow.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        case 2:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.red
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.red.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        case 3:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.green
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.green.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        case 4:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.blue
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.blue.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        case 5:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.cyan
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.cyan.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        case 6:
            let generator = EFQRCodeGenerator(content: textForQr)
            selectedColor = UIColor.cyan
            
            if flaggSquare == true {
                generator.withPointStyle(squarePositionMarker)
            }
            else if flaggCircle == true {
                generator.withPointStyle(circlePositionMarker)
            }
            else if flaggDiamond == true {
                generator.withPointStyle(diamondPositionMarker)
            }
            
            generator.withColors(backgroundColor: UIColor.white.cgColor, foregroundColor: UIColor.black.cgColor)
            
            guard selectedWatermark != nil else { return }
            generator.withWatermark(selectedWatermark.cgImage)
            
            imageView.image = UIImage(cgImage: generator.generate()!)
            break
        default:
            print(1)
        }
    }
    

}
