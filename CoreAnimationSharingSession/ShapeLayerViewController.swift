//
//  ShapeLayer.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class ShapelayerViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 3000)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        let shapeLayer = createShapeLayer(shape: .circle, position: 0)
        scrollView.layer.addSublayer(shapeLayer)
        
        let starLayer = createShapeLayer(shape: .star, position: 1)
        scrollView.layer.addSublayer(starLayer)
        
        let triangeLayer = createShapeLayer(shape: .triangle, position: 2)
        scrollView.layer.addSublayer(triangeLayer)
        
//        strokeAndFillLayer.strokeColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        strokeAndFillLayer.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }
    
    
    func createShapeLayer(shape: Shape, position: Int) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let spacing: CGFloat = 20
        let size: CGFloat = 200
        let yOrigin = (CGFloat(position) * size) + (spacing * CGFloat(position + 1))
        let frame = CGRect(origin: CGPoint(x: 30, y: yOrigin),
                           size: CGSize(width: size, height: size))
        layer.frame = frame
        
        layer.path = shape.renderPath(layer).cgPath
        layer.fillColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        layer.strokeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        layer.lineWidth = 4
//        layer.borderWidth = 5
        
        return layer
    }
    
}



enum Shape {
    case circle
    case triangle
    case star
    
    func renderPath(_ layer: CALayer) -> UIBezierPath {
        switch self {
        case .circle:
            return renderCirclePath(layer)
        case .triangle:
            return renderTrianglePath(layer)
        case .star:
            return renderStarPath(layer)
        }
    }
    
    private func renderCirclePath(_ layer: CALayer) -> UIBezierPath {
        let bounds = layer.bounds
        return UIBezierPath(ovalIn: bounds)
    }
    
    private func renderTrianglePath(_ layer: CALayer) -> UIBezierPath {
        let bounds = layer.bounds
        let trianglePath = UIBezierPath()
        let topCenterPosition = CGPoint(x: bounds.midX, y: bounds.minY)
        trianglePath.move(to: topCenterPosition)
        
        let bottomLeftPosition = CGPoint(x: bounds.minX, y: bounds.maxY)
        let bottomRightPosition = CGPoint(x: bounds.maxX, y: bounds.maxY)
        trianglePath.addLine(to: bottomLeftPosition)
        trianglePath.addLine(to: bottomRightPosition)
        trianglePath.close()
        
        return trianglePath
    }
    
    private func renderStarPath(_ layer: CALayer) -> UIBezierPath {
        let starPath = UIBezierPath()
        let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
      
        let numberOfPoints = CGFloat(5.0)
        let numberOfLineSegments = Int(numberOfPoints * 2.0)
        let theta = .pi / numberOfPoints

        let circumscribedRadius = center.x
        let outerRadius = circumscribedRadius * 1.039
        let excessRadius = outerRadius - circumscribedRadius
        let innerRadius = CGFloat(outerRadius * 0.382)

        let leftEdgePointX = (center.x + cos(4.0 * theta) * outerRadius) + excessRadius
        let horizontalOffset = leftEdgePointX / 2.0

        // Apply a slight horizontal offset so the star appears to be more
        // centered visually
        let offsetCenter = CGPoint(x: center.x - horizontalOffset, y: center.y)

        // Alternate between the outer and inner radii while moving evenly along the
        // circumference of the circle, connecting each point with a line segment
        for i in 0..<numberOfLineSegments {
            let radius = i % 2 == 0 ? outerRadius : innerRadius

            let pointX = offsetCenter.x + cos(CGFloat(i) * theta) * radius
            let pointY = offsetCenter.y + sin(CGFloat(i) * theta) * radius
            let point = CGPoint(x: pointX, y: pointY)

            if i == 0 {
                starPath.move(to: point)
            } else {
                starPath.addLine(to: point)
            }
        }

        starPath.close()

        // Rotate the path so the star points up as expected
        var pathTransform  = CGAffineTransform.identity
        pathTransform = pathTransform.translatedBy(x: center.x, y: center.y)
        pathTransform = pathTransform.rotated(by: CGFloat(-.pi / 2.0))
        pathTransform = pathTransform.translatedBy(x: -center.x, y: -center.y)

        starPath.apply(pathTransform)
        
        return starPath
    }
    
}
