//
//  MaskViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 27/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class MaskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.layer.addSublayer(orangeLayer)
        view.layer.addSublayer(appleLogoLayer)
        
        orangeMaskedLayer.mask = appleLogoMaskedLayer
        view.layer.addSublayer(orangeMaskedLayer)
        
        title = "Masking Layer"
    }
    
    // Original layer without masking
    lazy var appleLogoLayer: CALayer = {
        let layer = CALayer()
        let image = UIImage(named: "applelogo")
        layer.contents = image?.cgImage
        layer.contentsGravity = .resizeAspect
        
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 50, width: 200, height: 200)
        return layer
    }()
    
    let orangeLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        layer.frame = CGRect(x: 20, y: 250, width: 200, height: 200)
        return layer
    }()
    
    
    // Layer with masking
    lazy var appleLogoMaskedLayer: CALayer = {
        let layer = CALayer()
        let image = UIImage(named: "applelogo")
        layer.contents = image?.cgImage
        layer.contentsGravity = .resizeAspect
        
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        return layer
    }()
    
    let orangeMaskedLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        layer.frame = CGRect(x: 20, y: 450, width: 200, height: 200)
        return layer
    }()
    
    
    
}
