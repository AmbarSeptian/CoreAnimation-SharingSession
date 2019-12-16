//
//  DemoViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 30/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
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
    
    lazy var buttonLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let frame = bounds
        
        configureLayer: do {
            layer.frame = frame
            layer.cornerRadius = bounds.width / 2
        }
    
        configureGradient: do {
            layer.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) , #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)].map({ $0.cgColor })
            layer.locations = [0, 0.2]
            layer.startPoint = CGPoint(x: 0.5, y: 0.2)
            layer.endPoint = CGPoint(x: 1, y: 1)
            layer.type = .radial
        }
        
        configureShadow: do {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 10)
            layer.shadowOpacity = 0.6
            layer.shadowRadius = 8
            
            let path = UIBezierPath(ovalIn: frame).cgPath
            layer.shadowPath = path
        
            layer.masksToBounds = false
        }
     
        
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
         layer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)].map({ $0.cgColor })
        return layer
     }()
    
    lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let inset = UIEdgeInsets(15)
        let frame = bounds
        layer.frame = frame
        layer.path = UIBezierPath(ovalIn: frame.inset(by: inset)).cgPath
        layer.lineWidth = 15
        layer.fillColor = UIColor.clear.cgColor
        layer.transform = CATransform3DMakeRotation(-90 / 180 * .pi, 0, 0, 1)
        layer.strokeColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return layer
    }()
    
    lazy var rippleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let frame = bounds
        layer.frame = frame
        layer.path = UIBezierPath(ovalIn: frame).cgPath
        layer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return layer
    }()
    
    lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        configureLayer: do {
            let replicatorFrame = bounds
            replicatorLayer.frame = replicatorFrame
            
        }

        configureInstanceLayer: do {
            let instanceCount = 5
            replicatorLayer.instanceCount = instanceCount
            replicatorLayer.instanceDelay = 1
            replicatorLayer.addSublayer(rippleLayer)
        }
        
        return replicatorLayer
    }()
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didViewTapped(_:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSublayers()
        addGestureRecognizer(tapGesture)
    }
    
    @objc func didViewTapped(_ sender: UITapGestureRecognizer) {
        let duration: Double = 4
        startAnimation: do {
            animateRotateCircle(layer: circleLayer, duration: duration)
            animateCircleScale(layer: rippleLayer, duration: duration)
            animateArrow(layer: downArrowLayer, duration: duration)
        }
      
        pressButton(buttonLayer: buttonLayer)
    }
    
    func pressButton(buttonLayer: CAGradientLayer) {
        buttonLayer.colors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)].map({ $0.cgColor })
        buttonLayer.locations = [0, 0.2]
        buttonLayer.startPoint = CGPoint(x: 0.8, y: 0.8)
        buttonLayer.endPoint = CGPoint(x: 0, y: 0)

        buttonLayer.shadowOffset = CGSize(width: 0, height: 0)
        buttonLayer.shadowOpacity = 0.6
        buttonLayer.shadowRadius = 5
    }
    
    func addSublayers() {
        addSublayers: do {
            layer.addSublayer(replicatorLayer)
            layer.addSublayer(buttonLayer)
            layer.addSublayer(gradientLayer)
            layer.addSublayer(circleLayer)
            layer.addSublayer(downArrowLayer)
        }
       
        masking: do {
           gradientLayer.mask = cloudLayer
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRotateCircle(layer: CAShapeLayer, duration: Double) {
        let strokeEndAnimation: CABasicAnimation
        let rotateAnimation: CABasicAnimation
        let strokeColorAnimation: CABasicAnimation
        let animationGroup: CAAnimationGroup
        
        configureStrokeEndAnimation: do {
            strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.fromValue = 0.2
            strokeEndAnimation.toValue = 1
        }

        configureRotateAnimation: do {
            rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.toValue = CGFloat.pi * 4
        }

        configureStrokeColorAnimation: do {
            strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
            strokeColorAnimation.fromValue = layer.strokeColor
            strokeColorAnimation.toValue = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor
        }
        
        configureAnimationGroup: do {
            animationGroup = CAAnimationGroup()
            animationGroup.animations = [strokeEndAnimation, rotateAnimation, strokeColorAnimation]
            animationGroup.duration = duration
        }

        setFinalValue: do {
            layer.fillMode = .forwards
            layer.strokeEnd = 1
            layer.strokeColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor
        }
       
        startAnimation: do {
            layer.add(animationGroup, forKey: nil)
        }
    }
    
    func animateCircleScale(layer: CALayer, duration: Double) {
        let opacityAnimation: CABasicAnimation
        let scaleAnimation: CABasicAnimation
        let animationGroup: CAAnimationGroup
        
        configureOpacityAnimation: do {
            opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
        }
        
        configureScaleAnimation: do {
            scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.5
            scaleAnimation.toValue = 2
        }

        configureAnimationGroup: do {
            animationGroup = CAAnimationGroup()
            animationGroup.animations = [opacityAnimation, scaleAnimation]
            animationGroup.duration = duration
            animationGroup.isRemovedOnCompletion = false
            animationGroup.fillMode = .forwards
        }
        
        startAnimation: do {
            layer.add(animationGroup, forKey: nil)
        }
    }
    
    func animateArrow(layer: CAShapeLayer, duration: Double) {
        let bounds = layer.bounds
        let keyFrameAnimation: CAKeyframeAnimation
        
        let arrowShape: UIBezierPath
        let arrowFirstPath: UIBezierPath
        let arrowSecondPath: UIBezierPath
        
        let checkmarkShape: UIBezierPath
        let checkmarkSecondPath: UIBezierPath

        createKeyFrameAnimation: do {
            keyFrameAnimation = CAKeyframeAnimation()
            keyFrameAnimation.duration = duration
            keyFrameAnimation.keyPath = "path"
            keyFrameAnimation.isAdditive = true
        }
        
        createArrowPaths: do{
            let arrowGenerator = ArrowShapeGenerator(frame: bounds)
            arrowShape = arrowGenerator.createShape()
            arrowFirstPath = arrowGenerator.createFirstPath()
            arrowSecondPath = arrowGenerator.createSecondPath()
        }
        
        createCheckmarkPaths: do {
            let checkmarkGenerator = CheckmarkGenerator(frame: bounds)
            checkmarkShape = checkmarkGenerator.createShape()
            checkmarkSecondPath = checkmarkGenerator.createSecondPath()
        }
        
        addPathsToKeyFrameAnimation: do {
            let paths = [arrowShape,
                          arrowSecondPath,
                          arrowFirstPath,
                          checkmarkSecondPath,
                          checkmarkShape
                ].map{( $0.cgPath )}
            
            keyFrameAnimation.values = paths
            keyFrameAnimation.keyTimes =  [0, 0.4, 0.5, 0.6, 0.7]
        }
        
        setFinalValue: do {
           layer.path = checkmarkShape.cgPath
        }
        
        startAnimation: do {
           layer.add(keyFrameAnimation, forKey: nil)
        }
    }

    lazy var downArrowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        let inset = UIEdgeInsets(120)
        let frame = bounds.inset(by: inset)
        let center = CGRect(origin: .zero, size: frame.size)
        
        layer.frame = frame
        
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


