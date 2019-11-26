//
//  GradientLayer.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class GradientLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.addSublayer(linearLayer)
        view.layer.addSublayer(radialLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
     let linearLayer: CAGradientLayer = {
         let layer = CAGradientLayer()
         layer.frame = CGRect(x: 20, y: 300, width: 200, height: 200)
         layer.colors = [UIColor.blue, UIColor.purple, UIColor.brown].map({ $0.cgColor })
         layer.locations = [0, 0.5, 1].map({ NSNumber(value: $0) })
         return layer
     }()
    
    let radialLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 20, y: 300, width: 200, height: 200)
        layer.colors = [UIColor.blue, UIColor.purple, UIColor.brown].map({ $0.cgColor })
        layer.locations = [0, 0.5, 1].map({ NSNumber(value: $0) })
        return layer
    }()

}


