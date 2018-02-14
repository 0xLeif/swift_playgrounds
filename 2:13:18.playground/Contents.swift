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

//Create Geometry
let geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.25)
//Change Color
geometry.firstMaterial?.diffuse.contents = UIColor.red
//Create SCNNode
let boxNode = SCNNode(geometry: geometry)
//Add Node to Scene
sceneView.scene?.rootNode.addChildNode(boxNode)

//Do 1 action
boxNode.runAction(SCNAction.rotateBy(x: 0, y: CGFloat.pi, z: 0, duration: 5))

//Do animations
SCNTransaction.begin()
SCNTransaction.animationDuration = 5

omnidirectionalLightNode.position = SCNVector3(x:0, y:15, z:0)

SCNTransaction.commit()
