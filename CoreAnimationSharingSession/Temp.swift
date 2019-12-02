//
//  Coba2.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 02/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class Coba2iewController: UIViewController {
    
    lazy var radialLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        layer.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)].map({ $0.cgColor })
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.type = .radial
        return layer
    }()
    
    
    lazy var indicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        
        let circleLayer = CALayer()
        circleLayer.backgroundColor = UIColor.blue.cgColor
        circleLayer.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.cornerRadius = 10
        circleLayer.position = CGPoint(x: 20, y: 100)
        
        replicatorLayer.addSublayer(circleLayer)
        animateReplicator(layer: circleLayer)
        
        let instanceCount = 20
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = 1 / CFTimeInterval(instanceCount)
        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        return replicatorLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.layer.addSublayer(radialLayer)
//        view.addSubview(buttonView)
        
        let anim = CABasicAnimation(keyPath: "colors")
        anim.toValue = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)].map({ $0.cgColor })
        anim.duration = 5
        radialLayer.add(anim, forKey: nil)
        
        view.layer.addSublayer(indicatorLayer)
    }
    
    func animateReplicator(layer: CALayer) {
        layer.opacity = 0
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 1
        opacityAnimation.repeatCount = .infinity
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0.1
        scaleAnimation.duration = 1
        scaleAnimation.repeatCount = .infinity
        
        layer.add(opacityAnimation, forKey: nil)
        layer.add(scaleAnimation, forKey: nil)
    }
}
