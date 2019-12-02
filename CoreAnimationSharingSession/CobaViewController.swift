//
//  CobaViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 30/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class CobaViewController: UIViewController {
    lazy var buttonView: ASDFView = {
        return ASDFView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(buttonView)
    }

}


class ASDFView: UIView {
    lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        layer.frame = frame
        layer.path = UIBezierPath(ovalIn: frame).cgPath
        layer.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        layer.lineWidth = 2
        layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
        layer.strokeColor = UIColor.black.cgColor
        
        return layer
    }()
    
    lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        let replicatorFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
        replicatorLayer.frame = replicatorFrame
        
        let circleLayer = CAShapeLayer()
        circleLayer.frame = replicatorFrame
        circleLayer.path = UIBezierPath(ovalIn: replicatorFrame).cgPath
        circleLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        replicatorLayer.addSublayer(circleLayer)
        
        let instanceCount = 5
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = 1
        
        animateCircleScale(layer: circleLayer)
        
        return replicatorLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(replicatorLayer)
        layer.addSublayer(circleLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRotateCircle(layer: CAShapeLayer) {
        layer.strokeEnd = 0
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 2
        
//        let scaleAnimation = CABasicAnimation(keyPath: "transform")
//        scaleAnimation.fromValue = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 0)
//        scaleAnimation.toValue = CATransform3DScale(CATransform3DIdentity, 2, 2, 0)
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [strokeEndAnimation, scaleAnimation]
//        animationGroup.duration = 3
//        animationGroup.repeatCount = .infinity
//        animationGroup.fillMode = .forwards
//
//        layer.add(animationGroup, forKey: nil)
    }
    
    func animateCircleScale(layer: CALayer) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.5
        scaleAnimation.toValue = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]
        animationGroup.duration = 3
        animationGroup.repeatCount = .infinity
        animationGroup.fillMode = .forwards

        layer.add(animationGroup, forKey: nil)
        
        

    }
}
