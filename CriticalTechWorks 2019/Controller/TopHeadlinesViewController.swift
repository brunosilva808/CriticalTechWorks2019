//
//  ViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UITableViewController {
    
    private var articles: [Article]?
    private let sessionProvider = URLSessionProvider()
    private var headlineViewController: HeadlineViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Top Headlines in " + NSLocale().getCountryCode()
        setupTableView()
        getTopHeadlines()
    }

    private func setupTableView() {
        tableView.alpha = 1.0
        tableView.register(UINib(nibName: HeadlineTableViewCell.nibName, bundle: nil),
                                 forCellReuseIdentifier: HeadlineTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    func getTopHeadlines() {
        let countryCode = NSLocale().getCountryCode()
        sessionProvider.request(type: News.self,
                                service: NewsService.headlines(countryCode: countryCode)) { [weak self] (response) in
            switch response {
            case let .success(news):
                DispatchQueue.main.async {
                    self?.articles = news.articles.sorted(by: { return $0.publishedAt > $1.publishedAt })

                    self?.tableView.reloadData()
                    self?.tableView.alpha = 1.0
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}

extension TopHeadlinesViewController {
    
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
