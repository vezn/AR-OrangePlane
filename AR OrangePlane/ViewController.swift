//
//  ViewController.swift
//  AR OrangePlane
//
//  Created by Andrey Kedr on 23/01/2019.
//  Copyright © 2019 Andrey Kedr. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Освещение сцены
        
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        if  let campus = loadCampus() {
                scene.rootNode.addChildNode(campus)
        }
        
        let programmaticCampus = loadProgramamticCampus()
        scene.rootNode.addChildNode(programmaticCampus)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func loadCampus() -> SCNNode? {
        guard let scene = SCNScene(named: "art.scnassets/Campus.scn") else {return nil}
        
        let node = scene.rootNode.clone()
        
        return node
    }
    
    func loadProgramamticCampus() -> SCNNode {
        let campusNode = SCNNode()
        
        let buildingNode = loadBuilding()
       
        let treeNode = loadTree()
        
        campusNode.runAction(
            .repeatForever(
                .rotateBy(x: 0, y: -.pi, z: 0, duration: 2)))
        
        buildingNode.position.z -= 3
        campusNode.addChildNode(buildingNode)
        
        campusNode.addChildNode(treeNode)
        
        return campusNode
    }
    
    func loadBuilding() -> SCNNode {
        let buildingNode = SCNNode()
        
        let boxNode = SCNNode(geometry: SCNBox(width: 3, height: 2, length: 1, chamferRadius: 0))
        boxNode.position.y = 1
        
       // let building = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        
        
       /* var materials = [SCNMaterial]()
        
        [UIColor.red, .orange, .yellow, .blue, .gray, .purple].forEach { color in
            let material = SCNMaterial()
            
             material.diffuse.contents = color
             materials.append(material)
        }
      
        building.materials = materials */
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        
      // boxNode.geometry = building
        
        buildingNode.addChildNode(boxNode)
        
        
        let grassNode = SCNNode(geometry: SCNPlane(width: 6, height: 2))
        
        grassNode.eulerAngles.x -= .pi/2
        
        grassNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        buildingNode.addChildNode(grassNode)
        
        return buildingNode
    }
    
    func loadTree() -> SCNNode {
        let treeNode = SCNNode()
        
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 1))
        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        treeNode.addChildNode(sphereNode)
        
        sphereNode.position.y = 2.776
        
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 2))
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        treeNode.addChildNode(cylinderNode)
        
        cylinderNode.position.y = 1
        
        
        treeNode.position = SCNVector3( -2.5,  0, -3)
        
        let treeNodeLeft1 = treeNode.clone()
        treeNodeLeft1.position = SCNVector3( 5,  0, -0.75)
        let treeNodeRight2 = treeNode.clone()
        treeNodeRight2.position = SCNVector3( 0,  0, -0.75)
        let treeNodeLeft2 = treeNode.clone()
        treeNodeLeft2.position = SCNVector3( 5,  0, 0.75)
        let treeNodeRight3 = treeNode.clone()
        treeNodeRight3.position = SCNVector3( 0,  0, 0.75)
        let treeNodeLeft3 = treeNode.clone()
        treeNodeLeft3.position = SCNVector3( 5,  0, 0)
        
        treeNode.addChildNode(treeNodeLeft1)
        treeNode.addChildNode(treeNodeRight2)
        treeNode.addChildNode(treeNodeLeft2)
        treeNode.addChildNode(treeNodeRight3)
        treeNode.addChildNode(treeNodeLeft3)
     
        
        return treeNode
    }
    
    // let scene = SCNScene(named: "art.scnassets/ship.scn")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
