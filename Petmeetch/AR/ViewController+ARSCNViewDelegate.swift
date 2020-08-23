//
//  ViewController+ARSCNViewDelegate.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let isAnyObjectInView = virtualObjectLoader.loadedObjects.contains { object in
            return sceneView.isNode(object, insideFrustumOf: sceneView.pointOfView!)
        
        }
        DispatchQueue.main.async {
            
            self.updateFocusSquare(isObjectVisible: isAnyObjectInView)
            if !self.virtualObjectLoader.loadedObjects.isEmpty {
                self.focusSquare.isHidden = true
                self.addObjectButton.isHidden = true
                //MARK: -功能鍵hidden close
                self.feedbutton.isHidden = false
                self.spinbutton.isHidden = false
                self.sitbutton.isHidden = false
                self.getdownbutton.isHidden = false
                self.statusViewController.Petmood.isHidden = false
                self.countlabel.isHidden = false
        
            }
            else{
                self.focusSquare.isHidden = false
                self.addObjectButton.isHidden = false
                self.feedbutton.isHidden = true
                self.spinbutton.isHidden = true
                self.sitbutton.isHidden = true
                self.getdownbutton.isHidden = true
                self.statusViewController.Petmood.isHidden = true
                self.countlabel.isHidden = true

            }

            
            // If the object selection menu is open, update availability of items
            if self.objectsViewController?.viewIfLoaded?.window != nil {
                self.objectsViewController?.updateObjectAvailability()
            }
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.statusViewController.cancelScheduledMessage(for: .planeEstimation)
            self.statusViewController.showMessage(NSLocalizedString("SURFACE DETECTED", comment: "SURFACE DETECTED"))
            if self.virtualObjectLoader.loadedObjects.isEmpty {
                self.statusViewController.scheduleMessage(NSLocalizedString("TAP + TO PLACE YOUR PET", comment: "TAP + TO PLACE YOUR PET"), inSeconds: 7.5, messageType: .contentPlacement)
            }
            
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        updateQueue.async {
            if let objectAtAnchor = self.virtualObjectLoader.loadedObjects.first(where: { $0.anchor == anchor }) {
                objectAtAnchor.simdPosition = anchor.transform.translation
                objectAtAnchor.anchor = anchor
            }
        }
    }
    
    /// - Tag: ShowVirtualContent
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
        switch camera.trackingState {
        case .notAvailable, .limited:
            statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
        case .normal:
            statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
            showVirtualContent()
        }
    }

    func showVirtualContent() {
        virtualObjectLoader.loadedObjects.forEach { $0.isHidden = false }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            self.displayErrorMessage(title: NSLocalizedString("The AR session failed.", comment: "The AR session failed."), message: errorMessage)
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Hide content before going into the background.
        hideVirtualContent()
    }
    
    /// - Tag: HideVirtualContent
    func hideVirtualContent() {
        virtualObjectLoader.loadedObjects.forEach { $0.isHidden = true }
    }

    /*
     Allow the session to attempt to resume after an interruption.
     This process may not succeed, so the app must be prepared
     to reset the session if the relocalizing status continues
     for a long time -- see `escalateFeedback` in `StatusViewController`.
     */
    /// - Tag: Relocalization
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
}
