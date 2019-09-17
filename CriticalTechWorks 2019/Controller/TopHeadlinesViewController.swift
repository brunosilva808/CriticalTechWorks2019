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
    private let cellIdentifier = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        getNews()
    }
    
    func getNews() {

        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            sessionProvider.request(type: News.self, service: NewsService.headlines(country: countryCode)) { [weak self] (response) in
                switch response {
                case let .success(news):
                    print(news)
                    self?.news = news
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = news?.articles[indexPath.row].title
        return cell
    }
}
