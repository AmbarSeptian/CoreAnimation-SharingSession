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
        layer.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return layer
    }()
    
    lazy var circularLayer: CAShapeLayer = {
          let layer = CAShapeLayer()
          let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
          let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
          layer.frame = frame
          layer.path = UIBezierPath(ovalIn: frame.inset(by: inset)).cgPath
          layer.lineWidth = 10
          layer.fillColor = UIColor.clear.cgColor
          layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
          layer.strokeColor = UIColor.white.cgColor
          
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
        layer.addSublayer(circularLayer)
        layer.addSublayer(downArrowLayer)
        
        animateRotateCircle(layer: circularLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRotateCircle(layer: CAShapeLayer) {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.2
        strokeEndAnimation.toValue = 1
//        strokeEndAnimation.duration = 2
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue = CGFloat.pi * 4
        //        rotateAnimation.duration = 5

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, rotateAnimation]
        animationGroup.duration = 4

        layer.add(animationGroup, forKey: nil)
//        layer.strokeEnd = 1
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
    
    
    lazy var downArrowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        let inset = UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60)
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                    .inset(by: inset)
        
        layer.path = renderCheckmarkPath(frame: frame).cgPath
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 10
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        return layer
    }()
    
    func renderDownArrowPath(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.minY)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX, y: frame.midX)
        path.addLine(to: bottomMiddlePoint)
        
        let topRightPoint = CGPoint(x: frame.maxX, y: frame.minY)
        path.addLine(to: topRightPoint)
        return path
    }
    
    
    func renderCheckmarkPath(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX + 10, y: frame.minY + 20)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX - 10, y: frame.midY)
        path.addLine(to: bottomMiddlePoint)
        
        let topRightPoint = CGPoint(x: frame.maxX + 10, y: frame.minY)
        path.addLine(to: topRightPoint)
        return path
    }
}
