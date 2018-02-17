//: A SpriteKit based Playground

import PlaygroundSupport
import SceneKit

//Setup View
let sceneView = SCNView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = SCNScene(named: "//physics.scn")!
sceneView.scene = scene
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

let cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.camera?.wantsHDR = true
cameraNode.camera?.fieldOfView = 120
cameraNode.position = SCNVector3(x:0, y:1, z:105)
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
geometry.firstMaterial?.diffuse.contents = UIColor.green

var shaders: [SCNShaderModifierEntryPoint : String] = [:]

shaders[SCNShaderModifierEntryPoint.fragment] = """
const float PIover2 = (3.14159265358979 / 2.0);
const float lineTolerance = 1.0;

float dotProduct = dot(_surface.view, _surface.normal);

if ( !((PIover2 + lineTolerance) >= dotProduct && dotProduct >= (PIover2 - lineTolerance)) ) {
_output.color.rgba = vec4(0.3, 0.8, 0.6, 1.0);
}
"""

geometry.firstMaterial?.shaderModifiers = shaders
//Create SCNNode
let boxNode = SCNNode(geometry: geometry)
//Add Physics
boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: geometry, options: nil))
boxNode.physicsBody?.mass = 3
boxNode.position = SCNVector3(x: 0, y: 1, z: 100)
//Add Node to Scene
sceneView.scene?.rootNode.addChildNode(boxNode)
//Create Force
let force = SCNVector3Make(0,
						   CFloat(50),
						   -100)
// Apply Vector3 force to node
boxNode.physicsBody?.applyForce(force, at: SCNVector3(), asImpulse: true)

let text = SCNText(string: "oneleif", extrusionDepth: 1)
text.firstMaterial?.diffuse.contents = UIColor.green
let node = SCNNode(geometry: text)
node.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
node.position = SCNVector3(x: -1.5, y: 2, z: 0)
sceneView.scene?.rootNode.addChildNode(node)
// Make camera look at box
let distanceCon = SCNDistanceConstraint(target: boxNode)
distanceCon.minimumDistance = 2
distanceCon.maximumDistance = 10

let acccCon = SCNAccelerationConstraint()
acccCon.maximumLinearAcceleration = 80
acccCon.maximumLinearVelocity = 100

cameraNode.constraints = [SCNLookAtConstraint(target: boxNode),
						  distanceCon,
						  acccCon]

