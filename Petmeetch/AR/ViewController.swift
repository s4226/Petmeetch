//
//  ViewController.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//
//
import UIKit
import SceneKit
import ARKit
import SnapKit

var labradormoodcount = 0
var goldenmoodcount = 0
var mixmoodcount = 0
var lastTimeEndDate = Date()
class ViewController: UIViewController{
    
    @IBOutlet var sceneView: VirtualObjectARView!
    
    @IBOutlet weak var addObjectButton: UIButton!
    
    @IBOutlet weak var feedbutton: UIButton!
    
    @IBOutlet weak var spinbutton: UIButton!
    
    @IBOutlet weak var sitbutton: UIButton!
    
    @IBOutlet weak var getdownbutton: UIButton!
    
    var timer: Timer?
    
    @IBOutlet weak var petmood: UIImageView!
    
//    @IBOutlet weak var countlabel: UILabel!

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var spinner :UIActivityIndicatorView!
    
    @IBOutlet weak var upperControlsView:UIView!
    
    let coachingOverlay = ARCoachingOverlayView()
    
    var focusSquare = FocusSquare()
    //animation
    var animations = [String: CAAnimation]()
    
    //initial model
    var idle:Bool = true
    
    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return children.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    /// The view controller that displays the virtual object selection menu.
    var objectsViewController: VirtualObjectSelectionViewController?
    
    // MARK: - ARKit Configuration Properties
    
    /// A type which manages gesture manipulation of virtual content in the scene.
    lazy var virtualObjectInteraction = VirtualObjectInteraction(sceneView: sceneView, viewController: self)
    
    /// Coordinates the loading and unloading of reference nodes for virtual objects.
    let virtualObjectLoader = VirtualObjectLoader()
    
    /// Marks if the AR experience is available for restart.
    var isRestartAvailable = true
    
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.example.apple-samplecode.arkitexample.serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.snp.makeConstraints{(make) in
            make.left.right.top.bottom.equalTo(self.view)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        upperControlsView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(170)
        }        

        record()
        moodChange()
        //MARK: -互動鍵隱藏
        feedbutton.isHidden = true
        spinbutton.isHidden = true
        sitbutton.isHidden = true
        getdownbutton.isHidden = true
        sceneView.delegate = self
        sceneView.session.delegate = self
        // Set up coaching overlay.
        setupCoachingOverlay()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
//        // Set up scene content.
        sceneView.scene.rootNode.addChildNode(focusSquare)
        
        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showVirtualObjectSelectionViewController))
        // Set the delegate to ensure this gesture is only used when there are no virtual objects in the scene.
        tapGesture.delegate = self
        sceneView.addGestureRecognizer(tapGesture)
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.moodChange()
            if modelname == "Labrador" || modelname == "Golden Retriever"
            {
                self.sitbutton.setImage(UIImage(named: "sit"), for: .normal)
                self.getdownbutton.setImage(UIImage(named: "lie"), for: .normal)
                self.spinbutton.setImage(UIImage(named: "turn"), for: .normal)
                self.feedbutton.setImage(UIImage(named: "food"), for: .normal)
            }
            else if modelname == "mix"
            {
                self.sitbutton.setImage(UIImage(named: "cat_sit"), for: .normal)
                self.getdownbutton.setImage(UIImage(named: "cat_lie"), for: .normal)
                self.spinbutton.setImage(UIImage(named: "cat_play"), for: .normal)
                self.feedbutton.setImage(UIImage(named: "food"), for: .normal)
            }
        }
        

        timer =  Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { (timer) in
            
            if modelname == "Labrador"
            {
                labradormoodcount = labradormoodcount - 5
                if labradormoodcount < 0
                {
                    labradormoodcount = 0
                }

            }
            else if modelname == "Golden Retriever"
            {
                goldenmoodcount = goldenmoodcount - 5
                if goldenmoodcount < 0
                {
                    goldenmoodcount = 0
                }

            }
            else if modelname == "mix"
            {
                mixmoodcount = mixmoodcount - 5
                if mixmoodcount < 0
                {
                    mixmoodcount = 0
                }
            }
            self.moodChange()
        }

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.setNeedsFocusUpdate()
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Start the `ARSession`.
        resetTracking()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //儲存遊戲資料
        userDefaults.set(labradormoodcount, forKey: "labradormoodcount")
        userDefaults.set(goldenmoodcount, forKey: "goldenmoodcount")
        userDefaults.set(mixmoodcount, forKey: "mixmoodcount")
        userDefaults.set(Date(), forKey: "EndDate")
        //        userDefaults.synchronize()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        session.pause()
    }
    
    // MARK: - Session management
       
       // Creates a new AR configuration to run on the `session`.
       func resetTracking() {
           
           let configuration = ARWorldTrackingConfiguration()
           configuration.planeDetection = .horizontal
           if #available(iOS 12.0, *) {
               configuration.environmentTexturing = .automatic
           }
           session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

           statusViewController.scheduleMessage(NSLocalizedString("FIND A SURFACE TO PLACE YOUR PET", comment: "FIND A SURFACE TO PLACE YOUR PET"), inSeconds: 7.5, messageType: .planeEstimation)
       }
     // MARK: - Focus Square

       func updateFocusSquare(isObjectVisible: Bool) {
        
           if isObjectVisible || coachingOverlay.isActive {
               focusSquare.hide()
           }
           else{
               focusSquare.unhide()
               statusViewController.scheduleMessage(NSLocalizedString("TRY MOVING LEFT OR RIGHT", comment: "TRY MOVING LEFT OR RIGHT"), inSeconds: 5.0, messageType: .focusSquare)
           }
           
           // Perform ray casting only when ARKit tracking is in a good state.
           if let camera = session.currentFrame?.camera, case .normal = camera.trackingState,
               let query = sceneView.getRaycastQuery(),
               let result = sceneView.castRay(for: query).first {
               self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
               updateQueue.async {
                   self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                   self.focusSquare.state = .detecting(raycastResult: result, camera: camera)
               }
               if !coachingOverlay.isActive {
                   addObjectButton.isHidden = false
               }
               statusViewController.cancelScheduledMessage(for: .focusSquare)
           } else {
            self.focusSquare.state = .initializing
               updateQueue.async {
                   self.focusSquare.state = .initializing
                   self.sceneView.pointOfView?.addChildNode(self.focusSquare)
               }
               addObjectButton.isHidden = true
               objectsViewController?.dismiss(animated: false, completion: nil)
           }
       }
    // MARK: - Error handling
    
    func displayErrorMessage(title: String, message: String) {
        // Blur the background.
        blurView.isHidden = false
        
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: NSLocalizedString("Restart Session", comment: "Restart Session"), style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.blurView.isHidden = true
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
     func loadAnimation(withKey: String, sceneName:String, animationIdentifier:String) {
               let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
               let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
               
               if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
                   // The animation will only play once
                   animationObject.repeatCount = 1
                   // To create smooth transitions between animations
                   animationObject.fadeInDuration = CGFloat(1)
                   animationObject.fadeOutDuration = CGFloat(0.5)
                   
                   // Store the animation for later use
                   animations[withKey] = animationObject
               }
           }
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        sceneView.scene.rootNode.addAnimation(animations[key]!, forKey: key)
        
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
        sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: sceneView)
        
        // Let's test if a 3D Object was touch
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        
        let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
        
        if hitResults.first != nil {
            if(idle) {
                playAnimation(key: "Walking")
                let billoardConstraint = SCNBillboardConstraint()
                billoardConstraint.freeAxes = SCNBillboardAxis.Y
                virtualObjectInteraction.selectedObject!.constraints = [billoardConstraint]
                RunLoop.current.run(until:Date()+1)
                virtualObjectInteraction.selectedObject?.constraints = []

                
            }
            return
        }

    }
    //MARK: -取得紀錄
    func record()
    {
        labradormoodcount = userDefaults.integer(forKey: "labradormoodcount")
        print(labradormoodcount)
        goldenmoodcount = userDefaults.integer(forKey: "goldenmoodcount")
        print(goldenmoodcount)
        mixmoodcount = userDefaults.integer(forKey: "mixmoodcount")
        print(mixmoodcount)
        lastTimeEndDate = userDefaults.object(forKey: "EndDate") as? Date ?? Date()
        print("上次結束時間\(String(describing: lastTimeEndDate))")
        let now = Date()
        print("開始時間：\(now)")
        let interval = now.timeIntervalSince(lastTimeEndDate )
        //  計算經過多少30分鐘
        let time = (interval / 60.0 ) / 30.0
        print("次數\(time)")
        labradormoodcount  = labradormoodcount - Int(time * 15)

        if labradormoodcount < 0
        {
            labradormoodcount = 0
        }
        goldenmoodcount  = goldenmoodcount - Int(time * 15)

        if goldenmoodcount < 0
        {
            goldenmoodcount = 0
        }
        mixmoodcount = mixmoodcount - Int(time * 15)
        
        if mixmoodcount < 0
        {
            mixmoodcount = 0
        }
        moodChange()
    }
    //MARK: -寵物心情變化
    func moodChange()
    {
        if modelname == "Labrador"
        {
//            countlabel.text = "\(labradormoodcount)"
            if (labradormoodcount > 61)
            {
                statusViewController.Petmood.image = UIImage(named: "happy")
            }
            else if (labradormoodcount < 21)
            {
                
                statusViewController.Petmood.image = UIImage(named: "sad")
            }
            else
            {
                statusViewController.Petmood.image = UIImage(named: "smile")
            }

        }
        if modelname == "Golden Retriever"
        {
//            countlabel.text = "\(goldenmoodcount)"
            if (goldenmoodcount > 61)
            {
                statusViewController.Petmood.image = UIImage(named: "happy")
            }
            else if (goldenmoodcount < 21)
            {
                
                statusViewController.Petmood.image = UIImage(named: "sad")
            }
            else
            {
                statusViewController.Petmood.image = UIImage(named: "smile")
            }

        }
        if modelname == "mix"
        {
//            countlabel.text = "\(mixmoodcount)"
            if (mixmoodcount > 61)
            {
                statusViewController.Petmood.image = UIImage(named: "happy")
            }
            else if (mixmoodcount < 21)
            {
                
                statusViewController.Petmood.image = UIImage(named: "sad")
            }
            else
            {
                statusViewController.Petmood.image = UIImage(named: "smile")
            }

        }

    }

    @IBAction func feedbuttonTapped(_ sender: UIButton) {
        let bowl = sceneView.scene.rootNode.childNode(withName: "bowl", recursively: true)
        if idle{
            bowl?.isHidden = false
            print("eat")
            playAnimation(key: "eat")
            if modelname == "Labrador"
            {
                labradormoodcount = labradormoodcount + 15
                if labradormoodcount > 100
                {
                    labradormoodcount = 100
                }
//                countlabel.text = "\(labradormoodcount)"
                moodChange()
            }
            else if modelname == "Golden Retriever"
            {
                goldenmoodcount = goldenmoodcount + 15
                if goldenmoodcount > 100
                {
                    goldenmoodcount = 100
                }
//                countlabel.text = "\(goldenmoodcount)"
                moodChange()
            }
            else if modelname == "mix"
            {
                mixmoodcount = mixmoodcount + 15
                if mixmoodcount > 100
                {
                    mixmoodcount = 100
                }
//                countlabel.text = "\(mixmoodcount)"
                moodChange()
            }

        }
        RunLoop.current.run(until:Date()+4)
        bowl?.isHidden = true

    }
    @IBAction func spinbuttonTapped(_ sender: UIButton){
        animations["spin"]?.speed = 1.5
        print("spin")
        playAnimation(key: "spin")
        if modelname == "Labrador"
        {
            labradormoodcount = labradormoodcount + 15
            if labradormoodcount > 100
            {
                labradormoodcount = 100
            }
//            countlabel.text = "\(labradormoodcount)"
            moodChange()
        }
        else if modelname == "Golden Retriever"
        {
            goldenmoodcount = goldenmoodcount + 15
            if goldenmoodcount > 100
            {
                goldenmoodcount = 100
            }
//            countlabel.text = "\(goldenmoodcount)"
            moodChange()
        }
        else if modelname == "mix"
        {
            mixmoodcount = mixmoodcount + 15
            if mixmoodcount > 100
            {
                mixmoodcount = 100
            }
//            countlabel.text = "\(mixmoodcount)"
            moodChange()
        }


    }
    
    @IBAction func sitbuttonTapped(_ sender: UIButton) {
        print("sitdown")
        playAnimation(key: "sitdown")
        if modelname == "Labrador"
        {
            labradormoodcount = labradormoodcount + 15
            if labradormoodcount > 100
            {
                labradormoodcount = 100
            }
//            countlabel.text = "\(labradormoodcount)"
            moodChange()
        }
        else if modelname == "Golden Retriever"
        {
            goldenmoodcount = goldenmoodcount + 15
            if goldenmoodcount > 100
            {
                goldenmoodcount = 100
            }
//            countlabel.text = "\(goldenmoodcount)"
            moodChange()
        }
        else if modelname == "mix"
        {
//            mixmoodcount = mixmoodcount + 15
            if mixmoodcount > 100
            {
                mixmoodcount = 100
            }
//            countlabel.text = "\(mixmoodcount)"
            moodChange()
        }

    }
    
    @IBAction func getdownbuttonTapped(_ sender: UIButton) {
        print("getdown")
        playAnimation(key: "getdown")
        if modelname == "Labrador"
        {
            labradormoodcount = labradormoodcount + 15
            if labradormoodcount > 100
            {
                labradormoodcount = 100
            }
//            countlabel.text = "\(labradormoodcount)"
            moodChange()
        }
        else if modelname == "Golden Retriever"
        {
            goldenmoodcount = goldenmoodcount + 15
            if goldenmoodcount > 100
            {
                goldenmoodcount = 100
            }
//            countlabel.text = "\(goldenmoodcount)"
            moodChange()
        }
        else if modelname == "mix"
        {
            mixmoodcount = mixmoodcount + 15
            if mixmoodcount > 100
            {
                mixmoodcount = 100
            }
//            countlabel.text = "\(mixmoodcount)"
            moodChange()
        }

    }
    
}
class ARSceneUtils {
        /// return the distance between anchor and camera.
        class func distanceBetween(anchor : ARAnchor,AndCamera camera: ARCamera) -> CGFloat {
        let anchorPostion = SCNVector3Make(
            anchor.transform.columns.3.x,
            anchor.transform.columns.3.y,
            anchor.transform.columns.3.z
        )
        let cametaPosition = SCNVector3Make(
            camera.transform.columns.3.x,
            camera.transform.columns.3.y,
            camera.transform.columns.3.z
        )
        return CGFloat(self.calculateDistance(from: cametaPosition , to: anchorPostion))
    }

    /// return the distance between 2 vectors.
    class func calculateDistance(from: SCNVector3, to: SCNVector3) -> Float {
        let x = from.x - to.x
        let y = from.y - to.y
        let z = from.z - to.z
        return sqrtf( (x * x) + (y * y) + (z * z))
    }

}
