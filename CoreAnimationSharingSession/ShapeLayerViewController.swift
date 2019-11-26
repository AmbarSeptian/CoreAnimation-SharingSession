//
//  ShapeLayer.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class ShapelayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.addSublayer(shapeLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let frame = CGRect(origin: CGPoint(x: 20, y: 100), size: CGSize(width: 200, height: 200))
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

}

