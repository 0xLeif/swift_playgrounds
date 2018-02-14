//: A SpriteKit based Playground

import PlaygroundSupport
import SceneKit

//Setup View
let sceneView = SCNView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = SCNScene()
sceneView.scene = scene
sceneView.allowsCameraControl = true
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

let cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(x:0, y:2, z:8)
scene.rootNode.addChildNode(cameraNode)
sceneView.pointOfView = cameraNode
scene.physicsWorld.gravity = SCNVector3(0,-9.8,0)

//Add Light
let omnidirectionalLightNode = SCNNode()
omnidirectionalLightNode.position = SCNVector3(x:0, y:5, z:10)
omnidirectionalLightNode.light = SCNLight()
omnidirectionalLightNode.light?.type = .omni
scene.rootNode.addChildNode(omnidirectionalLightNode)

//Add Floor
let floor = SCNNode()
floor.position = SCNVector3(x:0, y:-5, z:0)
floor.geometry = SCNFloor()
//Add Physics
floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNFloor(), options: nil))
scene.rootNode.addChildNode(floor)

//Create Geometry
let geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.25)
//Change Color
geometry.firstMaterial?.diffuse.contents = UIColor.red
//Create SCNNode
let boxNode = SCNNode(geometry: geometry)
//Add Physics
boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: geometry, options: nil))
boxNode.physicsBody?.mass = 3
//Add Node to Scene
sceneView.scene?.rootNode.addChildNode(boxNode)
//Create Force
let randomDirection: Float = arc4random_uniform(2) == 0 ? -1.0 : 1.0
let force = SCNVector3Make(randomDirection,
						   CFloat(50),
						   randomDirection)
// Apply Vector3 force to node
boxNode.physicsBody?.applyForce(force, at: SCNVector3(), asImpulse: true)
