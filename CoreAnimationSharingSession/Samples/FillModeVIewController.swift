//
//  FillModeVIewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 17/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit


class FillModeViewController: UIViewController {
    enum Fill: Int {
        case forwards = 0, backwards, both, removed
        var text: String {
            switch self {
            case .forwards:
                return "Forwards"
            case .backwards:
                return "Backwards"
            case .both:
                return "Both"
            case .removed:
                return "Removed"
            }
        }
        
        var fillMode: CAMediaTimingFillMode {
            switch self {
            case .forwards:
                return .forwards
            case .backwards:
                return .backwards
            case .both:
                return .both
            case .removed:
                return .removed
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        for i in 0..<4 {
            let fill = Fill(rawValue: i)!
            createLayer(fill: fill)
        }
    }
    
    
    func createLayer(fill: Fill) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blue.cgColor
        layer.frame = CGRect(x: CGFloat(fill.rawValue) * 100, y: 100, width: 75, height: 75)
        
        view.layer.addSublayer(layer)
        
        let anim = CABasicAnimation(keyPath: "position.y")
        anim.fromValue = 200
        anim.beginTime = CACurrentMediaTime() + 2
        anim.toValue = 300
        anim.duration = 5
        anim.fillMode = fill.fillMode
        anim.isRemovedOnCompletion = false
        
        let textLayer = CATextLayer()
        textLayer.string = NSAttributedString(string: fill.text, attributes: [.font: UIFont.systemFont(ofSize: 12)])
        textLayer.frame = CGRect(x: 0, y: 25, width: 75, height: 75)
        textLayer.backgroundColor = UIColor.orange.cgColor
        textLayer.foregroundColor = UIColor.white.cgColor
        
        layer.addSublayer(textLayer)
        layer.add(anim, forKey: nil)
    }
}
