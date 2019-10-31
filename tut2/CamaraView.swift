import AVFoundation
import UIKit

class CamaraView: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var productCode = ""
    
    var i = 0 {
        didSet {
            print("Hello World.")
            if i == 1 {
             showWebView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
        }
        
        //        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)

        
        let session = URLSession.shared
        let url = URL(string: "https://www3.consumer.org.hk/pricewatch/supermarket/index.php?keyword=4891944003716")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            //            print(data)
            // Do something...
            let datas = String(data: data!, encoding: .utf8)!
            
            //            print(datas)
            
            if let myRange = datas.range(of: "P000"){
                let a = myRange.lowerBound
                let b = datas.index(myRange.upperBound, offsetBy: 6)
                let mynewRange: Range = a..<b
                print(datas[mynewRange])
                self.productCode = String(datas[mynewRange])
                print("self.productCode " + self.productCode )
//                self.i = 1
            }
            else{
                print("No such substring exists")
                self.productCode = ""
            }
            
            DispatchQueue.main.async {
                self.showWebView()
            }
            
        })
        task.resume()
        
        
        
    }
    
    func showWebView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyboard.instantiateViewController(withIdentifier: "webViewStoryborad") as! WebView
        
        newViewController.productCode = self.productCode
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
