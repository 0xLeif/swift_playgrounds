//: A SpriteKit based Playground

import PlaygroundSupport
import SceneKit

//Setup View
let sceneView = SCNView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = SCNScene()
sceneView.scene = scene
sceneView.allowsCameraControl = true
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//Add Light
let omnidirectionalLightNode = SCNNode()
omnidirectionalLightNode.position = SCNVector3(x:0, y:5, z:10)
omnidirectionalLightNode.light = SCNLight()
omnidirectionalLightNode.light?.type = .omni
scene.rootNode.addChildNode(omnidirectionalLightNode)

//Load Ivysaur Scene
let ivy = SCNScene(named: "//Pokemon.scn")

//Create SCNode from rootNode
let ivyNode = ivy?.rootNode.childNode(withName: "ivysaur", recursively: true)
ivyNode?.scale = SCNVector3(0.1, 0.1, 0.1)

//Add Node to Scene
sceneView.scene?.rootNode.addChildNode(ivyNode!)

//Do 1 action
ivyNode?.runAction(SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 5))

