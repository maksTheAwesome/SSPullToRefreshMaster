//
//  ViewController.swift
//  SSPullToRefresh
//
//  Created by Maksym Lazebnyi on 1/14/18.
//  Copyright © 2018 FleetWit. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = SSPullToRefreshView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        refreshControl?.beginRefreshing()
        
        delay(5) { 
            self.refreshControl?.endRefreshing()
        }
    }


}

