//
//  ASDFViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 02/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class ASDFViewController: UIViewController {
   
   private let radarAnimation = "radarAnimation"
   private var animationLayer: CALayer?
   private var animationGroup: CAAnimationGroup?


   override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view, typically from a nib.
       
    let first = makeRadarAnimation(aniamted: true,color: .red, showRect: CGRect(x: 120, y: 150, width: 140, height: 140), isRound: true) //Location and size
    let second = makeRadarAnimation(aniamted: false, color: .blue, showRect: CGRect(x: 120, y: 150, width: 140, height: 140), isRound: true) //Location and size
       view.layer.addSublayer(first)
    view.layer.addSublayer(second)
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         animationLayer?.add(animationGroup!, forKey: radarAnimation)
    }

   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
   }
        //Action - start
   @IBAction func startAction(_ sender: UIButton) {
      
   }
        //Action-stop
   @IBAction func stopAction(_ sender: UIButton) {
       animationLayer?.removeAnimation(forKey: radarAnimation)
   }
   
    private func makeRadarAnimation(aniamted: Bool, color: UIColor, showRect: CGRect, isRound: Bool) -> CALayer {
                // 1. A dynamic wave
       let shapeLayer = CAShapeLayer()
       shapeLayer.frame = showRect
                // showRect maximum inscribed circle
   
       shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height)).cgPath
       
                shapeLayer.fillColor = color.cgColor //Ripple color
        if aniamted {
             shapeLayer.opacity = 0.0 // default initial color transparency
        }
               
       
      
       
                // 2. Need to repeat the dynamic wave, that is, create a copy
        let replicator = CAReplicatorLayer()
        if aniamted {
            
                  replicator.frame = shapeLayer.bounds
                  replicator.instanceCount = 4
                  replicator.instanceDelay = 1.0
                  replicator.addSublayer(shapeLayer)
             animationLayer = shapeLayer
        } else {
            return shapeLayer
        }
      
       
                // 3. Create an animation group
       let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                opacityAnimation.fromValue = NSNumber(floatLiteral: 1.0) // Start transparency
                opacityAnimation.toValue = NSNumber(floatLiteral: 0) // Transparent bottom at the end
       
       let scaleAnimation = CABasicAnimation(keyPath: "transform")
       if isRound {
                        scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0)) // Zoom start size
       } else {
                        scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0)) // Zoom start size
       }
                scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 0)) // Zoom end size
       
       let animationGroup = CAAnimationGroup()
       animationGroup.animations = [opacityAnimation, scaleAnimation]
                animationGroup.duration = 3.0 // Animation execution time
                animationGroup.repeatCount = HUGE // maximum repeat
       animationGroup.autoreverses = false
        
       
       if aniamted {
        self.animationGroup = animationGroup
           shapeLayer.add(animationGroup, forKey: radarAnimation)
       }
       
       
       return replicator
   }

}

