//
//  ViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UITableViewController {
    
    var news: News?
    private let sessionProvider = URLSessionProvider()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getNews()
    }

    func setupTableView() {
        tableView.alpha = 1.0
        tableView.register(UINib(nibName: HeadlineTableViewCell.nibName, bundle: nil),
                                 forCellReuseIdentifier: HeadlineTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    func getNews() {

        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            sessionProvider.request(type: News.self, service: NewsService.headlines(country: countryCode)) { [weak self] (response) in
                switch response {
                case let .success(news):
                    self?.news = news
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.tableView.alpha = 1.0
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

}

extension TopHeadlinesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.cellIdentifier, for: indexPath)
            as! HeadlineTableViewCell

        if let article = news?.articles[indexPath.row] {
            cell.setup(article: article)
        }
        return cell
    }
}
