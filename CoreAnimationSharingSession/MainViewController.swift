//
//  MainViewController.swift
//  CoreAnimationSharingSession
//
//  Created by Ambar Septian on 15/12/19.
//  Copyright © 2019 Ambar Septian. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    let tableView = UITableView()

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

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let label = indexPath.row == 0 ? "Demo" : "Samples"
        cell.textLabel?.text = label
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController: UIViewController
        
        if indexPath.row == 0 {
            viewController = DemoViewController()
        } else {
            viewController = ExampleListViewController()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
