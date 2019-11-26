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
        view.layer.addSublayer(imageLayer)
    }
    
    
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
        layer.contentsRect = CGRect(x: 0.5, y: 0.5, width: 1, height: 1)
        
        layer.rasterizationScale = UIScreen.main.scale
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        return layer
    }()
    
    
//    lazy var wrapperMaskLayer: CALayer = {
//        let layer = CALayer()
////        layer.frame = CGRect(x: 100, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//    }()
    
}


// Masking
// Shadow
//
