//
//  ShapeGenerator.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 09/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

protocol ShapeGenerator {
    var frame: CGRect { get }
    func createShape() -> UIBezierPath
}

struct ArrowShapeGenerator: ShapeGenerator {
    let frame: CGRect
    
    func createFirstPath() -> UIBezierPath {
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        let path = UIBezierPath()
        path.move(to: topLeftPoint)
        path.addLine(to: topLeftPoint)
        
        return path
    }
    
    func createSecondPath() -> UIBezierPath{
        let path = createFirstPath()
        let bottomMiddlePoint = CGPoint(x: frame.midX, y: frame.maxY)
        path.addLine(to: bottomMiddlePoint)
        return path
    }
    
    func createThirdPath()  -> UIBezierPath {
        let path = createSecondPath()
        let topRightPoint = CGPoint(x: frame.maxX, y: frame.midY)
        path.addLine(to: topRightPoint)
        return path
    }
    
    func createShape() -> UIBezierPath {
        let path = createSecondPath()
        let topRightPoint = CGPoint(x: frame.maxX, y: frame.midY)
        path.addLine(to: topRightPoint)
        return path
    }
}

struct CheckmarkGenerator: ShapeGenerator {
    var frame: CGRect
    
    func createFirstPath() -> UIBezierPath {
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: frame.minX, y: frame.midY)
        path.move(to: topLeftPoint)
        path.addLine(to: topLeftPoint)
        
        return path
    }
    
    func createSecondPath() -> UIBezierPath {
        let path = createFirstPath()
        let bottomMiddlePoint = CGPoint(x: frame.midX - 10, y: frame.maxY - 10)
        path.addLine(to: bottomMiddlePoint)
        
        return path
     }
     
    func createShape() -> UIBezierPath {
        let path = createSecondPath()
        let topRightPoint = CGPoint(x: frame.maxX + 12, y: frame.midY - 15)
        path.addLine(to: topRightPoint)
        
        return path
    }
}


