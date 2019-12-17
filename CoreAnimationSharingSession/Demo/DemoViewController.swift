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


extension UIEdgeInsets {
    init(_ value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}


