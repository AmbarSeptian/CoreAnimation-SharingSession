//
//  CustomView2.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 17/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class CustomView2: UIView {
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didViewTapped(_:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSublayers()
        addGestureRecognizer(tapGesture)
    }
    
    @objc func didViewTapped(_ sender: UITapGestureRecognizer) {
        let duration: Double = 4
        
        startAnimation: do {
            
        }
    }
    
    func addSublayers() {
        addSublayers: do {
        
        }
        
        masking: do {
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
