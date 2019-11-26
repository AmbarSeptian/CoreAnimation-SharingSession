//
//  TransformLayerViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class TransformLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.addSublayer(transformLayer)
        
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = transformLayer.transform
        anim.toValue = CATransform3DMakeRotation(CGFloat.pi, 1, 1, 1)
        anim.duration = 2
        anim.isCumulative = true
        anim.repeatCount = .greatestFiniteMagnitude
        transformLayer.add(anim, forKey: "transform")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

    lazy var transformLayer: CATransformLayer = {
        let layer = CATransformLayer()
        
        // create the front face
        let transform1 = CATransform3DMakeTranslation(0, 0, 100)
        layer.addSublayer(createSublayer(transform: transform1, color: .blue))
        
        // create the right-hand face
        var transform2 = CATransform3DMakeTranslation(100, 0, 0)
        transform2 = CATransform3DRotate(transform2, CGFloat.pi / 2, 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform2, color: .green))
       
        // create the top face
        var transform3 = CATransform3DMakeTranslation(0, -100, 0)
        transform3 = CATransform3DRotate(transform3, CGFloat.pi / 2, 1, 0, 0)
        layer.addSublayer(createSublayer(transform: transform3, color: .black))
        
        // create the bottom face
        var transform4 = CATransform3DMakeTranslation(0, 100, 0)
        transform4 = CATransform3DRotate(transform4, -(CGFloat.pi / 2), 1, 0, 0)
        layer.addSublayer(createSublayer(transform: transform4, color: .cyan))
        
        // create the left-hand face
        var transform5 = CATransform3DMakeTranslation(-100, 0, 0)
        transform5 = CATransform3DRotate(transform5, -(CGFloat.pi / 2), 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform5, color: .brown))
        
        // create the back face
        var transform6 = CATransform3DMakeTranslation(0, 0, -100)
        transform6 = CATransform3DRotate(transform6, CGFloat.pi, 0, 1, 0)
        layer.addSublayer(createSublayer(transform: transform6, color: .magenta))
        
        layer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        return layer
    }()
    
    
    lazy var transformLayer2: CALayer = {
          let layer = CATransformLayer()
          
          // create the front face
          let transform1 = CATransform3DMakeTranslation(0, 0, 100)
        layer.addSublayer(createSublayer(transform: transform1, color: UIColor.blue.withAlphaComponent(0.3)))
          
          // create the right-hand face
          var transform2 = CATransform3DMakeTranslation(100, 0, 0)
          transform2 = CATransform3DRotate(transform2, CGFloat.pi / 2, 0, 1, 0)
          layer.addSublayer(createSublayer(transform: transform2, color: .green))
         
          // create the top face
          var transform3 = CATransform3DMakeTranslation(0, -100, 0)
//          transform3 = CATransform3DRotate(transform3, CGFloat.pi / 2, 1, 0, 0)
          layer.addSublayer(createSublayer(transform: transform3, color: .black))
          
          // create the bottom face
          var transform4 = CATransform3DMakeTranslation(0, 100, 0)
//          transform4 = CATransform3DRotate(transform4, -(CGFloat.pi / 2), 1, 0, 0)
          layer.addSublayer(createSublayer(transform: transform4, color: .cyan))
          
          // create the left-hand face
          var transform5 = CATransform3DMakeTranslation(-100, 0, 0)
//          transform5 = CATransform3DRotate(transform5, -(CGFloat.pi / 2), 0, 1, 0)
          layer.addSublayer(createSublayer(transform: transform5, color: .brown))
          
          // create the back face
          var transform6 = CATransform3DMakeTranslation(0, 0, -100)
//          transform6 = CATransform3DRotate(transform6, CGFloat.pi, 0, 1, 0)
          layer.addSublayer(createSublayer(transform: transform6, color: .magenta))
         
          layer.position = CGPoint(x: view.bounds.midX, y: 700)
          
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
        let size:CGFloat = 200
        let center = -(size / 2)
        
        layer.frame = CGRect(x: center, y: center, width: size, height: size)
        layer.transform = transform
        layer.borderWidth = 1
        layer.backgroundColor = color.cgColor
        
        return layer
    }
    
}

