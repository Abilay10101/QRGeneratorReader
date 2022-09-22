//
//  QRReaderVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 14.09.2022.
//

import UIKit
import AVFoundation
import AudioToolbox

class QRReaderVC: UIViewController , AVCaptureMetadataOutputObjectsDelegate{
    
    var video: AVCaptureVideoPreviewLayer!
    //Настройка сессии
    let session = AVCaptureSession()
    
    var flag = false
    var flagImage = false
    var flagFlashlite = false
    var flagChangeButton = false
    
    var soundFlag = true
    var vibroFlag = true
    
    var player : AVAudioPlayer?
    // 4095
    
    @IBOutlet weak var cameraZoomOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        startRunning()
    }
    
    
    func setupVideo () {
        //Настройка устройства видео
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        //Настройка inout
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input )
        } catch { fatalError(error.localizedDescription) }
        //Настройка output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        //Видео
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
    }
    
    func startRunning() {
        view.layer.addSublayer(video)
        session.startRunning()
    }
    
    func failed() {
            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "iphone_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            //player.prepareToPlay()

        } catch let error as NSError {
            print(error.description)
        }
        player!.play()
    }
    
    func vibrateDevice () {
        
    }

    @IBAction func startScanning(_ sender: UIButton) {
        startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if flagChangeButton == true {
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.ean8 ||  object.type == .ean13 || object.type == .pdf417 {
                    let alert = UIAlertController(title: "Bar Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Копировать", style: .default, handler: { action in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    present(alert, animated: true)
                    
                }
            }
            
        } else {
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Перейти", style: .default, handler: { action in
                        print(object.stringValue ?? "")
                    }))
                    alert.addAction(UIAlertAction(title: "Копировать", style: .default, handler: { action in
                        UIPasteboard.general.string = object.stringValue
                        //self.view.layer.sublayers?.removeLast()
                        //self.session.stopRunning()
                        
                        DispatchQueue.global(qos: .default).async {
                            self.playSound()
                        }
                        
                    }))
                    present(alert, animated: true)
                    
                    let userDefaults = UserDefaults()
                    if let data = userDefaults.object(forKey: "dataMata") {
                        if let message = data as? Bool {
                            self.soundFlag = message
                        }
                    }
                    
                    let userDefaults2 = UserDefaults()
                    if let data = userDefaults2.object(forKey: "dataMatka") {
                        if let message = data as? Bool {
                            self.vibroFlag = message
                        }
                    }
                    
                    if alert.isBeingPresented {
                        
                        if soundFlag && vibroFlag {
                            DispatchQueue.global(qos: .default).async {
                                self.playSound()
                                AudioServicesPlaySystemSound(SystemSoundID(4095))
                            }
                        }
                        else if soundFlag && !vibroFlag {
                            DispatchQueue.global(qos: .default).async {
                                self.playSound()
                                //AudioServicesPlaySystemSound(SystemSoundID(4095))
                            }
                        }
                        else if !soundFlag && vibroFlag {
                            DispatchQueue.global(qos: .default).async {
                                //self.playSound()
                                AudioServicesPlaySystemSound(SystemSoundID(4095))
                            }
                        } else {}
                        
                    }
                    
                    
                }
            }
        }
        
    }
    
    
    
    @IBAction func lightning(_ sender: UIBarButtonItem) {
        
        if flagFlashlite == false {
            sender.image = UIImage(systemName: "flashlight.off.fill")
            flagFlashlite = true
        } else {
            sender.image = UIImage(systemName: "flashlight.on.fill")
            flagFlashlite = false
        }
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if ((device?.hasTorch) != nil) {
            do {
                try device?.lockForConfiguration()
                device?.torchMode = device?.torchMode == AVCaptureDevice.TorchMode.on ? .off : .on
                device?.unlockForConfiguration()
            }catch {
                
            }
        }
    }
    
    @IBAction func cameraZoom(_ sender: UIBarButtonItem) {
        
        if flagImage == false {
            //cameraZoomOutlet.setBackgroundImage(UIImage(systemName: "minus.magnifyingglass"), for: .normal, barMetrics: .default)
            sender.image = UIImage(systemName: "minus.magnifyingglass")
            
            flagImage = true
        } else {
            //cameraZoomOutlet.setBackgroundImage(UIImage(systemName: "plus.magnifyingglass"), for: .normal, barMetrics: .default)
            sender.image = UIImage(systemName: "plus.magnifyingglass")
            flagImage = false
        }
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        let vZoomFactor = 1.0
        
        
        do {
            try device?.lockForConfiguration()
            defer {device?.unlockForConfiguration()}
            
            if (vZoomFactor <= Double((device?.activeFormat.videoMaxZoomFactor)!)) {
                
                let desiredZoomFactor:CGFloat?
                
                if self.flag == false {
                    desiredZoomFactor = vZoomFactor + atan2(10.0, 5.0);
                    self.flag = true
                } else {
                    desiredZoomFactor = vZoomFactor + atan2(0, 5.0);
                    self.flag = false
                }

                
                
                device?.videoZoomFactor = max(1.0, min(desiredZoomFactor!, (device?.activeFormat.videoMaxZoomFactor)!));
                
            } else { }
        } catch { }
    }
    
    
    
    @IBAction func changeCode(_ sender: UIBarButtonItem) {
        if flagChangeButton == true {
            flagChangeButton = false
            sender.image = UIImage(systemName: "barcode.viewfinder")
            self.title = "QR Scanner"
            print(flagChangeButton)
        } else {
            flagChangeButton = true
            sender.image = UIImage(systemName: "qrcode.viewfinder")
            self.title = "BC Scanner"
            print(flagChangeButton)
            failed()
        }
    }
    
    
}
