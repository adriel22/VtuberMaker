//
//  AvatarSceneViewController.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import UIKit
import SceneKit
import ARKit

class AvatarSceneViewController: UIViewController {
    
    @IBOutlet weak var assetsCollectionView: UICollectionView!
    @IBOutlet weak var faceView: SCNView!
    @IBOutlet weak var trackingView: ARSCNView!
    
    var contentNode: SCNReferenceNode?
    var cameraPosition = SCNVector3Make(0, 0, 10)
    let scene = SCNScene()
    let cameraNode = SCNNode()
    
    private var draggingNode: SCNNode?
    private var panStartZ: CGFloat = 0
    
    private let viewModel: AvatarSceneViewModel
    private var sceneNodes: [SCNNode] = []
    
    let panRecognizer = UIPanGestureRecognizer()
    var lastTouch: CGPoint = .zero
    var lastPanLocation: SCNVector3 = SCNVector3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        requestCameraAccess()
        
        
        panRecognizer.addTarget(self, action: #selector(moveNode(_:)))
        panRecognizer.minimumNumberOfTouches = 1
        view.addGestureRecognizer(panRecognizer)
    }
    
    init(_ viewModel: AvatarSceneViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AvatarSceneViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Auxiliar Methods
extension AvatarSceneViewController {
    private func setupCollection() {
        assetsCollectionView.delegate = self
        assetsCollectionView.dataSource = self
        assetsCollectionView.registerCell(type: AssetSelectionCollectionViewCell.self)
        assetsCollectionView.registerReusableHeaderFooter(type: AssetTypeSelectionHeader.self, kind: UICollectionView.elementKindSectionHeader)
    }
    
    private func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
            if granted {
                DispatchQueue.main.sync {
                    self.startTracking()
                }
            } else {
                fatalError("This app needs Camera Access to function. You can grant access in Settings.")
            }
        }
    }
    
    private func startTracking() {
        self.setupFaceTracker()
        self.createCameraNode()
    }
    
    @objc private func moveNode(_ sender:UIPanGestureRecognizer) {
        
        let location = sender.location(in: faceView)
        
        
        switch sender.state {
        case .began:
            guard let hittedNodeResult = faceView.hitTest(location).first else {return}
            draggingNode = hittedNodeResult.node
            lastPanLocation = hittedNodeResult.worldCoordinates
            panStartZ = CGFloat(faceView.projectPoint(lastPanLocation).z)
        case .changed:
            let location = sender.location(in: view)
            let worldTouchPosition = faceView.unprojectPoint(SCNVector3(location.x, location.y, panStartZ))
            draggingNode?.parent?.worldPosition = worldTouchPosition
//            draggingNode?.worldPosition = worldTouchPosition
            self.lastPanLocation = worldTouchPosition
        case .ended:
            draggingNode = nil
        default: break
        }
    }
}

// MARK: - Face tracking methods

extension AvatarSceneViewController {
    func setupFaceTracker() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        self.trackingView.session.run(configuration)
        self.trackingView.delegate = self
        self.trackingView.isHidden = true
    }
    
    func sceneSetup(withResource resource: String) {
        
        if let filePath = Bundle.main.path(forResource: resource,
                                           ofType: Constants.sceneType,
                                           inDirectory: Constants.sceneDirectory) {
            let referenceURL = URL(fileURLWithPath: filePath)
            
            self.contentNode = SCNReferenceNode(url: referenceURL)
            self.contentNode?.load()
            
            if let nodes = contentNode?.childNodes {
                self.sceneNodes.append(contentsOf: nodes)
            }
            self.scene.rootNode.addChildNode(self.contentNode!)
            self.scene.rootNode.position = SCNVector3(x: -3, y: 0, z: 0)
            contentNode?.position = SCNVector3(x: -3, y: 0, z: 0)
            
        }
        self.faceView.autoenablesDefaultLighting = true
        
        self.faceView.scene = self.scene
        self.faceView.allowsCameraControl = false
        self.faceView.backgroundColor = .clear
    }
    
    private func createCameraNode () {
        cameraNode.camera = SCNCamera()
        cameraNode.position = cameraPosition
        scene.rootNode.addChildNode(cameraNode)
        faceView.pointOfView = cameraNode
    }
}

extension AvatarSceneViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        DispatchQueue.main.async {
            let blendShapes = faceAnchor.blendShapes
            for (key, value) in blendShapes {
                if let fValue = value as? Float {
                    self.sceneNodes.forEach { plane in
                        plane.morpher?.setWeight(CGFloat(fValue), forTargetNamed: key.rawValue)
                    }
                }
            }
        }
    }
    
    
}


// MARK: - Collection Methods

extension AvatarSceneViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getAssetsTypes().count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getAssets(ofSection: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeue(withType: AssetSelectionCollectionViewCell.self, for: indexPath) { cell in
            let assets = self.viewModel.getAssets(ofSection: indexPath.section)
            cell.configure(assets[indexPath.item].thumbnail)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.dequeueReusableHeaderFooter(withType: AssetTypeSelectionHeader.self, kind: kind, indexPath: indexPath) { header in
            let type = self.viewModel.getType(ofSection: indexPath.section)
            header.configure(withType: type)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assetResource = viewModel.getAsset(forSection: indexPath.section, indexPath.item)
        sceneSetup(withResource: assetResource.file)
    }
    
}

fileprivate struct Constants {
    static let sceneDirectory = "Teste.scnassets"
    static let sceneType = "scn"
}
