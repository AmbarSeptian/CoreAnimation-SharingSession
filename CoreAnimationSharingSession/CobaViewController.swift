//
//  CobaViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 30/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class CobaViewController: UIViewController {
    lazy var customView: CustomView = {
        return CustomView(frame: CGRect(x: 50, y: 200, width: 300, height: 300))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(customView)
    }
}


class CustomView: UIView {
    let duration: TimeInterval = 4
    
    lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let frame = bounds
        let path = UIBezierPath(ovalIn: frame).cgPath
        layer.frame = frame
        layer.path = path
        layer.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
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
        layer.frame = bounds.inset(by: UIEdgeInsets(50))
        return layer
    }()
    
    
    lazy var gradientLayer: CAGradientLayer = {
         let layer = CAGradientLayer()
         let frame = bounds
         layer.frame = frame
         layer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.8722377419, green: 0.8722377419, blue: 0.8722377419, alpha: 1)].map({ $0.cgColor })
        return layer
     }()
    
    lazy var circularLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let inset = UIEdgeInsets(15)
        let frame = bounds
        layer.frame = frame
        layer.path = UIBezierPath(ovalIn: frame.inset(by: inset)).cgPath
        layer.lineWidth = 15
        layer.fillColor = UIColor.clear.cgColor
        layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
        layer.strokeColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        layer.strokeEnd = 0
        
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
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didViewTapped(_:)))
    
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
    
    func addSublayers() {
        addSublayers: do {
            layer.addSublayer(replicatorLayer)
            layer.addSublayer(circleLayer)
            layer.addSublayer(gradientLayer)
            layer.addSublayer(circularLayer)
            layer.addSublayer(downArrowLayer)
        }
       
        masking: do {
           gradientLayer.mask = cloudLayer
        }
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
        animationGroup.duration = duration
        
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
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        
        layer.add(animationGroup, forKey: nil)
    }
    
    func animateArrow(layer: CAShapeLayer) {
        let bounds = layer.bounds

        let keyFrameAnimation = CAKeyframeAnimation()
        keyFrameAnimation.keyTimes =  [0, 0.4, 0.5, 0.6, 0.7, 0.9]
        keyFrameAnimation.duration = duration
        keyFrameAnimation.keyPath = "path"
        keyFrameAnimation.isAdditive = true
        
        
        let arrowGenerator = ArrowShapeGenerator(frame: bounds)
        let arrowShape = arrowGenerator.createShape()
        let arrowFirstPath = arrowGenerator.createFirstPath()
        let arrowSecondPath = arrowGenerator.createSecondPath()
        
           let topLeftPoint = CGPoint(x: bounds.minX, y: bounds.midY)
             let path = UIBezierPath()
             path.move(to: topLeftPoint)
             path.addLine(to: topLeftPoint)
//        let arrowThirdPath = arrowGenerator.createThirdPath(arrowSecondPath)
        
        let checkmarkGenerator = CheckmarkGenerator(frame: bounds)
        let checkmarkShape = checkmarkGenerator.createShape()
        let checkmarkFirstPath = checkmarkGenerator.createFirstPath()
        let checkmarkSecondPath = checkmarkGenerator.createSecondPath()
        
        let paths = [ arrowShape,
                      arrowSecondPath,
                      arrowFirstPath,
                      checkmarkFirstPath,
                      checkmarkSecondPath,
                      checkmarkShape
            ].map{( $0.cgPath )}
        
        keyFrameAnimation.values = paths
        layer.path = checkmarkShape.cgPath
        layer.add(keyFrameAnimation, forKey: nil)
    }

    lazy var downArrowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        let inset = UIEdgeInsets(120)
        let frame = bounds
            .inset(by: inset)
        
        layer.frame = frame
        let center = CGRect(origin: .zero, size: frame.size)
        
        let arrowGenerator = ArrowShapeGenerator(frame: center)
        layer.path = arrowGenerator.createShape().cgPath
                        
        layer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        layer.lineWidth = 15
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineJoin = .round
        return layer
    }()
}


extension UIEdgeInsets {
    init(_ value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}


