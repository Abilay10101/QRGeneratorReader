//
//  QRReaderVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 14.09.2022.
//

import UIKit
import AVFoundation

class QRReaderVC: UIViewController , AVCaptureMetadataOutputObjectsDelegate{
    
    var video: AVCaptureVideoPreviewLayer!
    //Настройка сессии
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
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
    
    @IBAction func startScanning(_ sender: UIButton) {
        startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Перейти", style: .default, handler: { action in
                    print(object.stringValue ?? "")
                }))
                alert.addAction(UIAlertAction(title: "Копировать", style: .default, handler: { action in
                    UIPasteboard.general.string = object.stringValue
                    self.view.layer.sublayers?.removeLast()
                    self.session.stopRunning()
                }))
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func lightning(_ sender: UIBarButtonItem) {
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
        var device = AVCaptureDevice.default(for: AVMediaType.video)
        var vZoomFactor = 1.0
        var error:NSError!
        
        do {
            try device?.lockForConfiguration()
            defer {device?.unlockForConfiguration()}
            
            if (vZoomFactor <= Double((device?.activeFormat.videoMaxZoomFactor)!)) {

                let desiredZoomFactor:CGFloat = vZoomFactor + atan2(sender.velocity, 5.0);
                
                device?.videoZoomFactor = max(1.0, min(desiredZoomFactor, (device?.activeFormat.videoMaxZoomFactor)!));
                
            } else { }
        } catch { }
    }
    
    
}
