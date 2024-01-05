import SceneKit
import SwiftUI

struct ARViewContainer: View {
    let info: ElementInfo
    let pie: Double = .pi

    var body: some View {
        SceneView(scene: createAtomScene(), options: [.allowsCameraControl])
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }

    func createAtomScene() -> SCNScene {
            let scene = SCNScene()
            let nucleus = createNucleus()
            scene.rootNode.addChildNode(nucleus)

            var previousRingNode: SCNNode?

            for (shellIndex, shell) in info.shells.enumerated() {
                let ringRadius = Double(shellIndex + 1) * 2.5
                let ringNode = createRing(radius: ringRadius)

                if let previousNode = previousRingNode {
                    ringNode.position = SCNVector3(0, 0, 0)
                    previousNode.addChildNode(ringNode)
                } else {
                    ringNode.position = SCNVector3(0, 0, 0)
                    nucleus.addChildNode(ringNode)
                }

                for electronIndex in 0..<shell {
                    let angle = (360.0 / Double(shell)) * Double(electronIndex)
                    let electronNode = createElectron()
                    electronNode.position = positionOnRing(radius: ringRadius, angle: angle)
                    ringNode.addChildNode(electronNode)

                    // Perform rotation animation
                    let orbitAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * pie), z: 0, duration: 5.0) // Adjust rotation speed and duration as needed
                    let repeatAction = SCNAction.repeatForever(orbitAction)
                    electronNode.runAction(repeatAction)

                    // Enable shadow casting
                    electronNode.castsShadow = true
                }

                previousRingNode = ringNode
            }

            // Configure lighting
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light?.type = .ambient
            ambientLightNode.light?.color = UIColor.white.withAlphaComponent(0.3)
            scene.rootNode.addChildNode(ambientLightNode)

            let directionalLightNode = SCNNode()
            directionalLightNode.light = SCNLight()
            directionalLightNode.light?.type = .directional
            directionalLightNode.light?.intensity = 1000
            directionalLightNode.position = SCNVector3(x: 5, y: 5, z: 5)
            scene.rootNode.addChildNode(directionalLightNode)

            return scene
        }


    func createNucleus() -> SCNNode {
        let nucleus = SCNSphere(radius: 1.0)
        let nucleusNode = SCNNode(geometry: nucleus)
        nucleusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        return nucleusNode
    }

    func createRing(radius: Double) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(radius), pipeRadius: 0.1)
        let ringNode = SCNNode(geometry: ring)
        ringNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        return ringNode
    }

    func createElectron() -> SCNNode {
        let electron = SCNSphere(radius: 0.3) // Adjusted electron size
        let electronNode = SCNNode(geometry: electron)
        electronNode.geometry?.firstMaterial?.diffuse.contents = UIColor.black // Changed electron color
        return electronNode
    }

    func positionOnRing(radius: Double, angle: Double) -> SCNVector3 {
        let x = radius * cos(angle * .pi / 180) // Changed Y position calculation
        let z = radius * sin(angle * .pi / 180) // Z position calculation
        return SCNVector3(x, 0, z) // Return YZ plane vector
    }
}

#Preview {
    ARViewContainer(info: mockData)
}
