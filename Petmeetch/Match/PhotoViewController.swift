//
//  ViewController.swift
//  photo
//
//  Created by hbe11678 on 2020/8/3.
//  Copyright © 2020 hbe11678. All rights reserved.
//

import UIKit
import Vision
import CoreImage
class PhotoViewController: UIViewController {
    
    // TODO:- label display
    
    // MARK:- IBOutlets
    


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ChoosePhoto: UIButton!
    
    @IBOutlet weak var btn: UIButton!
    

    
    
    
    // MARK:- Properties
    var image: UIImage?
    let vowels: [Character] = ["a", "e", "i", "o", "u"]
    var rlt: String?
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //guard let image = UIImage(named: "Unknown") else {
            //fatalError("no myGifViewstarting image")
       //}

        //imageView.image = image
       //guard let ciImage = CIImage(image: image) else {
            //fatalError("couldn't convert UIImage to CIImage")
        //}
        
       //detectScene(image: ciImage)
    }
}

// MARK:- IBActions
extension PhotoViewController {
    @IBAction func ChoosePhotoButton() {
        pickPhoto()
    }
}

// MARK:- Methods
extension PhotoViewController {
    
    func detectScene(image: CIImage) {
        //        加载模型
        guard let model = try? VNCoreMLModel(for: finaltest().model) else {
            fatalError("Couldn't initialize Model")
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }

            let article = (self?.vowels.contains(topResult.identifier.first!))! ? "" : ""
            DispatchQueue.main.async { [weak self] in
                self?.btn.setTitle("\(article) \(topResult.identifier.components(separatedBy: ",")[0]) ", for: .normal)
                print("\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)")
                
                if let topResult = results.first{
                    if topResult.identifier.contains("Dog"){
                        self?.btn.setTitle("你適合養狗狗", for: .normal)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "page2")
                            self?.present(controller!, animated: true, completion: nil)
                        }
                        self!.userDefaults.set("狗 ", forKey: "type")

                    }else if let topResult = results.first{
                        if topResult.identifier.contains("Cat"){
                            self?.btn.setTitle("你適合養貓咪", for: .normal)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                let controller = self?.storyboard?.instantiateViewController(withIdentifier: "page3")
                                 self?.present(controller!, animated: true, completion: nil)
                            }
                            self!.userDefaults.set("貓 ", forKey: "type")

                        }
                    }
            }
                else if let topResult = results.first{
                    if topResult.identifier.contains("error"){
                        DispatchQueue.main.async {
                            self?.btn.setTitle("error", for: .normal)
                        }

                    }
                    self!.userDefaults.set("類型", forKey: "type")

                }
        }
    }
        
        //        在主线程上运行 Core ML GoogLeNetPlaces 分类器
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }

    }
}

// MARK:- ImagePickerControllerDelegate
extension PhotoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    // MARK:- Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        if let theImage = image {
            show(image: theImage)
        }
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }
        
        imageView.image = image
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)
        dismiss(animated: true, completion: nil)
        self.detect()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func detect() {
        let imageOptions =  NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
        let personciImage = CIImage(cgImage: imageView.image!.cgImage!)
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage, options: imageOptions as? [String : AnyObject])
        
        if let face = faces?.first as? CIFaceFeature {
            print("found bounds are \(face.bounds)")
            
            //let alert = UIAlertController(title: "", message: "We detected a face!", preferredStyle: UIAlertController.Style.alert)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
            
            if face.hasSmile {
                print("face is smiling");
            }
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        } else {
            let alert = UIAlertController(title: "", message: "偵測失敗,請再試一次！", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickPhoto() {
        
        /**
            Simulator does not have camera, So use `if true || UIImagePickerController.isSourceTypeAvailable(.camera) {`
            instead `if UIImagePickerController.isSourceTypeAvailable(.camera) {`.
        */
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: NSLocalizedString("Choose Image", comment: "Choose Image"), message: nil, preferredStyle: .actionSheet)
        let actCancel = UIAlertAction(title: NSLocalizedString("Cacel", comment: "Cancel"), style: .cancel, handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto =
            UIAlertAction(title: NSLocalizedString("Take Photo", comment: "Take Photo"),
                                     style: .default,
                                     handler: {
                                        _ in self.takePhotoWithCamera()
        })
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: NSLocalizedString("Choose From Library", comment: "Choose From Library"),
                                       style: .default,
                                       handler: {
                                        _ in self.choosePhotoFromLibrary()
        })
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
    }
    
    func show(image: UIImage) {
        imageView.image = image
        imageView.isHidden = false
        imageView.frame = CGRect(x: 60, y: 155, width: 257, height: 170)
    }
 

           



// MARK:- UINavigationControllerDelegate
//extension ViewController: UINavigationControllerDelegate {
    
//}






}

