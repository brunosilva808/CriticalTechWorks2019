//
//  FavoritesViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 20/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class FavoritesHeadlinesViewController: BaseHeadlinesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "favorites.title".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tmpArray = articles?.filter { $0.isSaved }
        if articles?.count != tmpArray?.count {
            articles = tmpArray
            tableView.reloadData()
        }
    }
    
}
