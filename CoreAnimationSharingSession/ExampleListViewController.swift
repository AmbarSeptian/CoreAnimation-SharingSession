//
//  ExampleListViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 26/11/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit

class ExampleListViewController: UIViewController {
    let tableView = UITableView()
    
    enum Example: CaseIterable {
        case basic, shapeLayer, gradientLayer, transformLayer
        var description: String {
            switch self {
            case .basic:
                return "Basic"
            case .shapeLayer:
                return "Shape Layer"
            case .gradientLayer:
                return "Gradient Layer"
            case .transformLayer:
                return "Transform Layer"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView: do {
            view.addSubview(tableView)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ExampleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Example.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Example.allCases[indexPath.row].description
        return cell
    }
}

extension ExampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let example = Example.allCases[indexPath.row]
        let viewController: UIViewController
        
        switch example {
        case .basic:
            viewController = BasicLayerViewController()
        case .shapeLayer:
            viewController = ShapelayerViewController()
        case .gradientLayer:
            viewController = GradientLayerViewController()
        case .transformLayer:
            viewController = TransformLayerViewController()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
