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
        let frame = bounds
        let path = UIBezierPath(ovalIn: frame).cgPath
        layer.frame = frame
        layer.path = path
        layer.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.shadowPath = path
        layer.masksToBounds = false
        
        return layer
    }()
    
    lazy var cloudLayer: CALayer = {
        let layer = CALayer()
        let image = UIImage(named: "cloud")
        layer.contents = image?.cgImage
        layer.contentsGravity = .resizeAspect
        
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        return layer
    }()
    
    
    lazy var gradientLayer: CAGradientLayer = {
         let layer = CAGradientLayer()
         let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
         layer.frame = frame
         layer.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)].map({ $0.cgColor })
         layer.startPoint = CGPoint(x: 0.5, y: 0.5)
         layer.endPoint = CGPoint(x: 1, y: 1)
         layer.type = .radial

         return layer
     }()
    
    lazy var circularLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let frame = bounds
        layer.frame = frame
        layer.path = UIBezierPath(ovalIn: frame.inset(by: inset)).cgPath
        layer.lineWidth = 15
        layer.fillColor = UIColor.clear.cgColor
        layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
        layer.strokeColor = UIColor.white.cgColor
        
        return layer
    }()
    
    lazy var ripleLayer: CAShapeLayer = {
        let ripleLayer = CAShapeLayer()
        let frame = bounds
        ripleLayer.frame = frame
        ripleLayer.path = UIBezierPath(ovalIn: frame).cgPath
        ripleLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return ripleLayer
    }()
    
    lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        let replicatorFrame = bounds
        replicatorLayer.frame = replicatorFrame
        replicatorLayer.addSublayer(ripleLayer)
        
        let instanceCount = 5
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = 1
        
        return replicatorLayer
    }()
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didViewTapped(_:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSublayers()
        addGestureRecognizer(tapGesture)
    }
    
    @objc func didViewTapped(_ sender: UITapGestureRecognizer) {
        animateRotateCircle(layer: circularLayer)
        animateArrow(layer: self.downArrowLayer)
        animateCircleScale(layer: ripleLayer)
    }
    
    private func addSublayers() {
        layer.addSublayer(replicatorLayer)
//        gradientLayer.mask = cloudLayer
//        layer.addSublayer(cloudLayer)
//        layer.addSublayer(gradientLayer)
        layer.addSublayer(circularLayer)
        layer.addSublayer(downArrowLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRotateCircle(layer: CAShapeLayer) {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.2
        strokeEndAnimation.toValue = 1
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue = CGFloat.pi * 4
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, rotateAnimation]
        animationGroup.duration = 4
        
        layer.add(animationGroup, forKey: nil)
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
    
    func animateArrow(layer: CAShapeLayer) {
        let bounds = layer.bounds
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: bounds.origin)
        path.addLine(to: bounds.origin)
        
        let keyFrameAnimation = CAKeyframeAnimation()
        keyFrameAnimation.keyTimes = [0, 0.5, 0.6, 0.7, 0.9]
        keyFrameAnimation.duration = 2
        keyFrameAnimation.keyPath = "path"
        keyFrameAnimation.isAdditive = true
        keyFrameAnimation.values = [
            layer.path ?? UIBezierPath(),
            self.renderDownArrowPath1(frame: bounds).cgPath,
                                    self.renderDownArrowPath2(frame: bounds).cgPath,
                                    self.renderCheckmarkPath1(frame: bounds).cgPath,
        self.renderCheckmarkPath(frame: bounds).cgPath
        ]
        layer.path = self.renderCheckmarkPath(frame:bounds).cgPath
        layer.add(keyFrameAnimation, forKey: nil)
    }
    
    //CLOUD
    
    lazy var downArrowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        let inset = UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60)
        let frame = bounds
            .inset(by: inset)
        
        layer.frame = frame
        let center = CGRect(origin: .zero, size: frame.size)
        layer.path = renderDownArrowPath(frame: center).cgPath
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 15
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineJoin = .round
        return layer
    }()
    
    func renderDownArrowPath(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX, y: frame.maxY)
        path.addLine(to: bottomMiddlePoint)
        
        let topRightPoint = CGPoint(x: frame.maxX, y: frame.midY)
        path.addLine(to: topRightPoint)
        return path
    }
    
    func renderDownArrowPath1(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX, y: frame.maxY)
        path.addLine(to: bottomMiddlePoint)
        return path
    }
    
    func renderDownArrowPath2(frame: CGRect) -> UIBezierPath {
         let path = UIBezierPath()
         let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
         path.move(to: topLeftPoint)
         path.addLine(to: topLeftPoint)
         return path
     }
    
    func renderCheckmarkPath(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX - 10, y: frame.maxY - 10)
        path.addLine(to: bottomMiddlePoint)
        
        let topRightPoint = CGPoint(x: frame.maxX + 12, y: frame.midY - 15)
        path.addLine(to: topRightPoint)
        return path
    }
    
    func renderCheckmarkPath1(frame: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        path.move(to: topLeftPoint)
        
        let bottomMiddlePoint = CGPoint(x: frame.midX - 10, y: frame.maxY - 10)
        path.addLine(to: bottomMiddlePoint)
        
        return path
    }
}
