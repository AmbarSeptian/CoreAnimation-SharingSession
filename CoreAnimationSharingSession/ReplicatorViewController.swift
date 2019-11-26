//
//  ReplicatorViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 27/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class ReplicatorViewController: UIViewController {

    let replicatorLayer = CAReplicatorLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        replicatorLayer.instanceCount = 20
        replicatorLayer.frame = CGRect(x: 50, y: 200, width: 300, height: 300)
        
        let angle = -CGFloat.pi * 2 / CGFloat(replicatorLayer.instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        // Change color per instance
        let offsetColor = -(1 / Float(replicatorLayer.instanceCount))
        replicatorLayer.instanceGreenOffset = offsetColor
        replicatorLayer.instanceRedOffset = offsetColor
        
//        replicatorLayer.instanceAlphaOffset = offsetColor
        
        let instanceLayer = CALayer()
        instanceLayer.frame = CGRect(x: 0, y: 0, width: 30, height: 8)
        instanceLayer.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        
        let yCenterOfReplicator = replicatorLayer.frame.height / 2
        let spacePerInstance: CGFloat = 20
        instanceLayer.position = CGPoint(x: spacePerInstance, y: yCenterOfReplicator)
        
        replicatorLayer.addSublayer(instanceLayer)
        replicatorLayer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        
        view.layer.addSublayer(replicatorLayer)
    }
}
