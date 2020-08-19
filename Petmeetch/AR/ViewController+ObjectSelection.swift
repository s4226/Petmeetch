//
//  ViewController+ObjectSelection.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit
import ARKit

extension ViewController: VirtualObjectSelectionViewControllerDelegate {
    
    /** Adds the specified virtual object to the scene, placed at the world-space position
     estimated by a hit test from the center of the screen.
     - Tag: PlaceVirtualObject */
    func placeVirtualObject(_ virtualObject: VirtualObject) {
        guard focusSquare.state != .initializing, let query = virtualObject.raycastQuery else {
            self.statusViewController.showMessage(NSLocalizedString("CANNOT PLACE YOUR PET\nTry moving left or right.", comment: "CANNOT PLACE YOUR PET\nTry moving left or right."))
            if let controller = self.objectsViewController {
                self.virtualObjectSelectionViewController(controller, didDeselectObject: virtualObject)
            }
            return
        }
       
        let trackedRaycast = createTrackedRaycastAndSet3DPosition(of: virtualObject, from: query,
                                                                  withInitialResult: virtualObject.mostRecentInitialPlacementResult)
        virtualObject.raycast = trackedRaycast
        virtualObjectInteraction.selectedObject = virtualObject
        virtualObject.isHidden = false
        
        
    }
    
    // - Tag: GetTrackedRaycast
    func createTrackedRaycastAndSet3DPosition(of virtualObject: VirtualObject, from query: ARRaycastQuery,
                                              withInitialResult initialResult: ARRaycastResult? = nil) -> ARTrackedRaycast? {
        if let initialResult = initialResult {
            self.setTransform(of: virtualObject, with: initialResult)
        }
        
        return session.trackedRaycast(query) { (results) in
            self.setVirtualObject3DPosition(results, with: virtualObject)
        }
    }
    
    func createRaycastAndUpdate3DPosition(of virtualObject: VirtualObject, from query: ARRaycastQuery) {
        guard let result = session.raycast(query).first else {
            return
        }
        
        if virtualObject.allowedAlignment == .horizontal && self.virtualObjectInteraction.trackedObject == virtualObject {
            
            // If an object that's aligned to a surface is being dragged, then
            // smoothen its orientation to avoid visible jumps, and apply only the translation directly.
            virtualObject.simdWorldPosition = result.worldTransform.translation
            
            let previousOrientation = virtualObject.simdWorldTransform.orientation
            let currentOrientation = result.worldTransform.orientation
            virtualObject.simdWorldOrientation = simd_slerp(previousOrientation, currentOrientation, 0.1)
        } else {
            self.setTransform(of: virtualObject, with: result)
        }
    }
    
    // - Tag: ProcessRaycastResults
    private func setVirtualObject3DPosition(_ results: [ARRaycastResult], with virtualObject: VirtualObject) {
        
        guard let result = results.first else {
            fatalError(NSLocalizedString("Unexpected case: the update handler is always supposed to return at least one result.", comment: "Unexpected case: the update handler is always supposed to return at least one result."))
        }
        
        self.setTransform(of: virtualObject, with: result)
        
        // If the virtual object is not yet in the scene, add it.
        if virtualObject.parent == nil {
            let bowlNode = virtualObject.childNode(withName: "bowl", recursively: true)
            bowlNode?.isHidden = true

            self.sceneView.scene.rootNode.addChildNode(virtualObject)
            
            // MARK: -let model follow camera rotation
//            let billoardConstraint = SCNBillboardConstraint()
//            billoardConstraint.freeAxes = SCNBillboardAxis.Y
//            virtualObject.constraints = [billoardConstraint]


                        // MARK: - intitial animation
            if(virtualObject.modelName == "Labrador")
            {
                // Load  the Walking animation
                self.loadAnimation(withKey: "Walking", sceneName: "art.scnassets/Labrador/LabradorWalking", animationIdentifier: "LabradorWalking-1")
                // Load  the breathing animation
                self.loadAnimation(withKey: "Breathing", sceneName: "art.scnassets/Labrador/LabradorBreathing", animationIdentifier: "LabradorBreathing-1")

                // Load  the sitdown animation
                self.loadAnimation(withKey: "sitdown", sceneName: "art.scnassets/Labrador/labradorsitdown", animationIdentifier: "labradorsitdown-1")
                // Load  the eat animation
                self.loadAnimation(withKey: "eat", sceneName: "art.scnassets/Labrador/Labradoreat", animationIdentifier: "Labradoreat-1")
                //Load  the play animation
                self.loadAnimation(withKey: "spin", sceneName: "art.scnassets/Labrador/LabradorPlaying", animationIdentifier: "LabradorPlaying-1")
                //Load the getdown animation
                self.loadAnimation(withKey: "getdown", sceneName: "art.scnassets/Labrador/LabradorGetDown", animationIdentifier: "LabradorGetDown-1")
                
            }

            virtualObject.shouldUpdateAnchor = true
        }
        
        if virtualObject.shouldUpdateAnchor {
            virtualObject.shouldUpdateAnchor = false
            self.updateQueue.async {
                self.sceneView.addOrUpdateAnchor(for: virtualObject)
            }
        }
    }
    
    func setTransform(of virtualObject: VirtualObject, with result: ARRaycastResult) {
        virtualObject.simdWorldTransform = result.worldTransform
    }

    // MARK: - VirtualObjectSelectionViewControllerDelegate
    // - Tag: PlaceVirtualContent
    func virtualObjectSelectionViewController(_: VirtualObjectSelectionViewController, didSelectObject object: VirtualObject) {
        virtualObjectLoader.loadVirtualObject(object, loadedHandler: { [unowned self] loadedObject in
            
            do {
                let scene = try SCNScene(url: object.referenceURL, options: nil)
                
                self.sceneView.prepare([scene], completionHandler: { _ in
                    DispatchQueue.main.async {
                        self.hideObjectLoadingUI()
                        self.placeVirtualObject(loadedObject)
                    }
                })
            } catch {
                fatalError(NSLocalizedString("Failed to load SCNScene from object.referenceURL", comment: "Failed to load SCNScene from object.referenceURL"))
            }
            
        })
        displayObjectLoadingUI()
        
    }
    
    func virtualObjectSelectionViewController(_: VirtualObjectSelectionViewController, didDeselectObject object: VirtualObject) {
        guard let objectIndex = virtualObjectLoader.loadedObjects.firstIndex(of: object) else {
            fatalError(NSLocalizedString("Programmer error: Failed to lookup virtual object in scene.", comment: "Programmer error: Failed to lookup virtual object in scene."))
        }
        virtualObjectLoader.removeVirtualObject(at: objectIndex)
        virtualObjectInteraction.selectedObject = nil
        if let anchor = object.anchor {
            session.remove(anchor: anchor)
        }
    }

    // MARK: Object Loading UI

    func displayObjectLoadingUI() {
        // Show progress indicator.
        spinner.startAnimating()
        
//        addObjectButton.setImage(#imageLiteral(resourceName: "buttonring"), for: [])

        addObjectButton.isEnabled = false
        isRestartAvailable = false
    }

    func hideObjectLoadingUI() {
        // Hide progress indicator.
        spinner.stopAnimating()

        addObjectButton.setImage(#imageLiteral(resourceName: "add"), for: [])
        addObjectButton.setImage(#imageLiteral(resourceName: "addPressed"), for: [.highlighted])

        addObjectButton.isEnabled = true
        isRestartAvailable = true
    }
    
}
