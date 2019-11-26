//
//  BasicLayerViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class BasicLayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = #colorLiteral(red: 0.8661591598, green: 0.8658027469, blue: 0.7614286672, alpha: 1).cgColor
        view.addSubview(basicView)
        
        view.layer.addSublayer(imageMaskLayer)
        imageMaskLayer.mask = imageLayer
        
        title = "Basic Layer"
    }
    
    let shapeLayer: CAShapeLayer = {
           let layer = CAShapeLayer()
           let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 400, height: 400))
           layer.frame = frame
           let bounds = layer.bounds
           
           let trianglePath = UIBezierPath()
           let topCenterPosition = CGPoint(x: bounds.midX, y: bounds.minY)
           trianglePath.move(to: topCenterPosition)
           
           let bottomLeftPosition = CGPoint(x: bounds.minX, y: bounds.maxY)
           let bottomRightPosition = CGPoint(x: bounds.maxX, y: bounds.maxY)
           trianglePath.addLine(to: bottomLeftPosition)
           trianglePath.addLine(to: bottomRightPosition)
           trianglePath.close()
           
           layer.path = trianglePath.cgPath
           layer.fillColor = UIColor.blue.cgColor
           layer.strokeColor = UIColor.black.cgColor
           layer.lineWidth = 10
           layer.backgroundColor = UIColor.gray.cgColor
           
           return layer
       }()
    
    let basicLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return layer
    }()
    
    lazy var basicView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.layer.addSublayer(basicLayer)
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        basicLayer.bounds = basicView.bounds
    }
    
    lazy var imageLayer: CALayer = {
        let layer = CALayer()
        let image = UIImage(named: "applelogo")
        layer.contents = image?.cgImage
        layer.contentsGravity = .resizeAspect
        
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        return layer
    }()
    
    let imageMaskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        layer.frame = CGRect(x: 100, y: 200, width: 300, height: 300)
        return layer
    }()
    
}


// Masking
// Shadow
//
