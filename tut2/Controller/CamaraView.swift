import AVFoundation
import UIKit
import CoreData

class CamaraView: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var productCode = ""
    
    //    let moc = (UIApplication.sharedApplication().delegate
    //    as! AppDelegate).managedObjectContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        save(title: "booktest123")
        readData()
        
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
    
    func save(title: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Book",
                                       in: managedContext)!
        
        let book = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        // 3
        book.setValue("name", forKeyPath: "title")
        
        // 4
        do {
            try managedContext.save()
            print("save")
            //        people.append(book)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func readData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        //3
        do {
            var books = try managedContext.fetch(fetchRequest)
            for b in books{
                print(b.value(forKey: "title"))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        

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
        //        let url = URL(string: "https://www3.consumer.org.hk/pricewatch/supermarket/index.php?keyword=" + code)!
        let url = URL(string: "https://isbnsearch.org/isbn/" + code)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            //            print(data)
            // Do something...
            //            let datas = String(data: data!, encoding: .utf8)!
            
            self.productCode = code
            
            //            print(datas)
            
            //            if let myRange = datas.range(of: "P000"){
            //                let a = myRange.lowerBound
            //                let b = datas.index(myRange.upperBound, offsetBy: 6)
            //                let mynewRange: Range = a..<b
            //                print(datas[mynewRange])
            //                self.productCode = String(datas[mynewRange])
            //                print("self.productCode " + self.productCode )
            ////                self.i = 1
            //            }
            //            else{
            //                print("No such substring exists")
            //                self.productCode = ""
            //            }
            
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
