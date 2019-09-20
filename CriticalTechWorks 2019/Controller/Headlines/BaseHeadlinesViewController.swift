//
//  BaseNewsViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 20/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class BaseHeadlinesViewController: UITableViewController {

    var articles: [Article]?
    var headlineViewController: HeadlineViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.alpha = 1.0
        tableView.register(UINib(nibName: HeadlineTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: HeadlineTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }

}

extension BaseHeadlinesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.cellIdentifier, for: indexPath)
            as! HeadlineTableViewCell
        
        if let article = articles?[indexPath.row] {
            cell.setup(article: article)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headlineViewController = HeadlineViewController()
        headlineViewController.article = articles?[indexPath.row]
        self.navigationController?.pushViewController(headlineViewController, animated: true)
    }
}
