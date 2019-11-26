//
//  TransformLayerViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class TransformLayerViewController: UIViewController {

    lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        return gesture
    }()
    
    let cubeWidth: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.addSublayer(transformLayer)
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        var transform = CATransform3DIdentity
        
        transform = CATransform3DRotate(transform, 1.0 / cubeWidth * translation.x, 0, 1, 0)
        transform = CATransform3DRotate(transform, -(1.0 / cubeWidth) * translation.y, 1, 0, 0)
        transformLayer.sublayerTransform = transform
    }
    

    lazy var transformLayer: CATransformLayer = {
        let layer = CATransformLayer()
        
        let translationValue = cubeWidth / 2
        // create the front face
        let transform1 = CATransform3DMakeTranslation(0, 0, translationValue)
        layer.addSublayer(createSublayer(transform: transform1, color: .blue))
        
        // create the right-hand face
        var transform2 = CATransform3DMakeTranslation(translationValue, 0, 0)
        transform2 = CATransform3DRotate(transform2, CGFloat.pi / 2, 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform2, color: .green))
       
        // create the top face
        var transform3 = CATransform3DMakeTranslation(0, -(translationValue), 0)
        transform3 = CATransform3DRotate(transform3, CGFloat.pi / 2, 1, 0, 0)
        layer.addSublayer(createSublayer(transform: transform3, color: .black))
        
        // create the bottom face
        var transform4 = CATransform3DMakeTranslation(0, translationValue, 0)
        transform4 = CATransform3DRotate(transform4, -(CGFloat.pi / 2), 1, 0, 0)
        layer.addSublayer(createSublayer(transform: transform4, color: .cyan))
        
        // create the left-hand face
        var transform5 = CATransform3DMakeTranslation(-(translationValue), 0, 0)
        transform5 = CATransform3DRotate(transform5, -(CGFloat.pi / 2), 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform5, color: .brown))
        
        // create the back face
        var transform6 = CATransform3DMakeTranslation(0, 0, -(translationValue))
        transform6 = CATransform3DRotate(transform6, CGFloat.pi, 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform6, color: .magenta))
        
        layer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        return layer
    }()
    
    let tiledLayer: CATiledLayer = {
        let layer = CATiledLayer()
        return layer
    }()
    
    let emittedLayer: CAEmitterLayer = {
        let layer = CAEmitterLayer()
        return layer
    }()
    
    let layer: CATextLayer = {
       let layer = CATextLayer()
        return layer
    }()
    
    
    func createSublayer(transform: CATransform3D, color: UIColor) -> CALayer {
        let layer = CALayer()
        let center = -(cubeWidth / 2)
        
        layer.frame = CGRect(x: center, y: center, width: cubeWidth, height: cubeWidth)
        layer.transform = transform
        layer.borderWidth = 1
        layer.backgroundColor = color.cgColor
        
        return layer
    }
    
}

