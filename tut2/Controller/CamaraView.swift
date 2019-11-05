import AVFoundation
import UIKit
import CoreData

class CamaraView: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var productCode = ""
    var bookData :BookModel?
    
    //    let moc = (UIApplication.sharedApplication().delegate
    //    as! AppDelegate).managedObjectContext
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        found(code: "9788831799003")
        //        save(title: "booktest123")
        //        readData()
        
        view.backgroundColor = UIColor(red:0.61, green:0.00, blue:0.06, alpha:1.0)
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
        //        previewLayer.frame = view.layer.bounds
        previewLayer.frame = CGRect(x: 0, y: 90, width: screenSize.width, height: screenSize.height-90)
        
        
        //        let mask = CALayer()
        ////        mask.backgroundColor = UIColor(red:156.00, green:0.00, blue:15.0, alpha:1.0).cgColor
        //        mask.backgroundColor = UIColor.red.cgColor
        ////         這邊我們必須設定顏色，否則沒有效果
        //
        //
        //        mask.frame = CGRect(x: 0, y: 50, width: screenSize.width, height: screenSize.height-30)
        //        previewLayer.mask = mask
        
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0, y: 53, width: screenSize.width, height: 30)
        textLayer.string = "Scanner"
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        //        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.fontSize = 20
        textLayer.contentsScale = 2.0
        
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        view.layer.addSublayer(textLayer)
        
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
        print("readData")
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
            return
        }
        dismiss(animated: true)
    }
    
    func restartScanner(){
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    
    func found(code: String) {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        
        
        let loadingalert = UIAlertController(title: "Loading...", message: "", preferredStyle: .alert)
        self.present(loadingalert, animated: true)
        
        print(code)
        
        bookData = BookJson.getdata(id:code)
        
        
        if(bookData != nil){
            DispatchQueue.main.async {
                loadingalert.dismiss(animated: true){
                self.showWebView()
                }
            }
        }else{
            let alert = UIAlertController(title: "No record found", message: "Please try agian", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

            loadingalert.dismiss(animated: true){
                self.present(alert, animated: true)
            }
            
            restartScanner()
        }
        
        //        let session = URLSession.shared
        //        //        let url = URL(string: "https://www3.consumer.org.hk/pricewatch/supermarket/index.php?keyword=" + code)!
        //        let url = URL(string: "https://isbnsearch.org/isbn/" + code)!
        //
        //        let task = session.dataTask(with: url, completionHandler: { data, response, error in
        //            //            print(data)
        //            // Do something...
        //            //            let datas = String(data: data!, encoding: .utf8)!
        //
        //            self.productCode = code
        //            //            print(datas)
        //
        //            //            if let myRange = datas.range(of: "P000"){
        //            //                let a = myRange.lowerBound
        //            //                let b = datas.index(myRange.upperBound, offsetBy: 6)
        //            //                let mynewRange: Range = a..<b
        //            //                print(datas[mynewRange])
        //            //                self.productCode = String(datas[mynewRange])
        //            //                print("self.productCode " + self.productCode )
        //            ////                self.i = 1
        //            //            }
        //            //            else{
        //            //                print("No such substring exists")
        //            //                self.productCode = ""
        //            //            }
        //
        //            DispatchQueue.main.async {
        //                self.showWebView()
        //            }
        //
        //        })
        //        task.resume()
        
        
        
    }
    
    func showWebView(){
        
        //                performSegue(withIdentifier: "showDetailinScanner", sender: self)
        
        //        let storyboard = UIStoryboard(name: "detailedView", bundle: nil)
        //
        //        let objVC = storyboard.instantiateViewController(withIdentifier: "detailview") as! DetailView
        //
        //
        //        let aObjNavi = UINavigationController(rootViewController: objVC)
        //
        //        self.navigationController?.pushViewController(aObjNavi, animated: true)
        
        
        let storyboard = UIStoryboard(name: "detailedView", bundle: nil)
        //
        let newViewController = storyboard.instantiateViewController(withIdentifier: "detailview") as! DetailView
        newViewController.modalPresentationStyle = .fullScreen
        //
        //                let navController = UINavigationController(rootViewController: newViewController)
        //
        newViewController.bookDataModel = self.bookData
        
        //                self.navigationController?.present(navController, animated: true, completion: nil)
        //                print("present")
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
