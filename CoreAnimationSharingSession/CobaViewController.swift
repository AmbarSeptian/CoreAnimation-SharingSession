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
//        layer.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        layer.lineWidth = 2
        layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
        layer.strokeColor = UIColor.black.cgColor
        
        return layer
    }()
    
    lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        let replicatorFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
        replicatorLayer.frame = replicatorFrame
        replicatorLayer.backgroundColor = UIColor.blue.cgColor
        
        let circleLayer = CAShapeLayer()
        circleLayer.frame = replicatorFrame
        circleLayer.path = UIBezierPath(ovalIn: replicatorFrame).cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        replicatorLayer.addSublayer(circleLayer)
        
        let instanceCount = 5
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = 1 / CFTimeInterval(instanceCount)
        replicatorLayer.instanceAlphaOffset = 0.05
        replicatorLayer.backgroundColor = UIColor.orange.cgColor
    
        let scale: CGFloat = 1.2
        replicatorLayer.instanceTransform = CATransform3DMakeScale(scale, scale, 0)
        return replicatorLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(replicatorLayer)
        layer.addSublayer(circleLayer)
        
        backgroundColor = .red
        
//        animateRotateCircle(layer: circleLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRotateCircle(layer: CAShapeLayer) {
        layer.strokeEnd = 0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.repeatCount = .infinity
        
        layer.add(animation, forKey: nil)
        
    }
}
