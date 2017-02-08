//
//  ViewController.swift
//  3DAnimation
//
//  Created by Rajesh M on 14/12/16.
//  Copyright © 2016 sasvathtech. All rights reserved.
//

import UIKit
import SceneKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    // Gestures
    var currentAngle: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneSetup()
        

        // Do any additional setup after loading the view.
    }
    
    
    func sceneSetup(){
        //1
        let scene = SCNScene()
        
        
        let ambientLightNode = SCNNode()
        
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 1.0 , alpha: 1.0)
        
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        //box Geometry
        
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 2.0)
        
        let boxNode = SCNNode(geometry: boxGeometry)
        
        scene.rootNode.addChildNode(boxNode)
        
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 25)
        scene.rootNode.addChildNode(cameraNode)
        
        
        geometryNode = boxNode
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        sceneView.addGestureRecognizer(panRecognizer)
        
        sceneView.allowsCameraControl = true

        //SceneView
        
        sceneView.scene = scene
        
//        sceneView.autoenablesDefaultLighting = true
        
        sceneView.allowsCameraControl = true
        
        
        
    }

    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        if(sender.state == UIGestureRecognizerState.Ended) { currentAngle = newAngle
        } }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}