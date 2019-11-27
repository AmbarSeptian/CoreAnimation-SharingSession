//
//  BasicLayerViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class BasicLayerViewController: UIViewController {
    lazy var basicView: BasicView = {
        let view = BasicView()
        view.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return view
    }()
    
    lazy var shadowLayer: ShadowLayer = {
        let layer = ShadowLayer()
        layer.frame = CGRect(x: 100, y: 400, width: 200, height: 200)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = #colorLiteral(red: 0.8661591598, green: 0.8658027469, blue: 0.7614286672, alpha: 1).cgColor
        view.addSubview(basicView)
        view.layer.addSublayer(shadowLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


class BasicView: UIView {
    let basicLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        layer.cornerRadius = 20
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(basicLayer)
        layer.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        basicLayer.frame = bounds.insetBy(dx: 10, dy: 10)
    }
}


class ShadowLayer: CALayer {
    override init() {
        super.init()
        backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowOpacity = 0.4
        shadowOffset =  CGSize(width: 0, height: 2)
        shadowRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        let path = UIBezierPath(rect: bounds)
        
        // Custom Shadow
//        let shadowSize: CGFloat = 10
//        let shadowDistance: CGFloat = 20
//        let rect = CGRect(x: -shadowSize, y: bounds.height + shadowDistance, width: bounds.width + (shadowSize * 2), height: shadowSize)
//        let path = UIBezierPath(ovalIn: rect)
//
        shadowPath = path.cgPath
    }
}
