//
//  ViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: BaseHeadlinesViewController {
    
    private let sessionProvider = URLSessionProvider()
    private var favoritesViewController: FavoritesHeadlinesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TopHeadlines.title".localized + Environment.sources.value
        getTopHeadlines()
        setupBarButton()
    }

    private func setupBarButton() {
        let button = UIBarButtonItem(title: "favorites.button.title.favorites".localized,
                                      style: .plain,
                                      target: self,
                                      action: #selector(rightBarButtonPressed))
        self.navigationItem.rightBarButtonItem  = button
    }
    
    func getTopHeadlines() {
        sessionProvider.request(type: News.self,
                                service: NewsService.headlines(countryCode: Environment.sources.value)) { [weak self] (response) in
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
    
    @objc private func rightBarButtonPressed() {
        favoritesViewController = FavoritesHeadlinesViewController()
        favoritesViewController.articles = articles?.filter { $0.isSaved }
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
    
}
