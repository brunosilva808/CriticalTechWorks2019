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
                    
                    let container = try! Container()
                    try! container.write { transaction in
                        if let article = self?.articles?.first {
                            transaction.add(article)
                        }
                    }
                }
            case let .failure(error):
                print(error)
                self?.getFakeData()
            }
        }
    }

    func getFakeData() {
        
        if let path = Bundle.main.path(forResource: "top_headlines_static", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try? JSONDecoder().decode(News.self, from: data)
                print(model)
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                    // do stuff
                    print(jsonResult)

                }
            } catch {
                // handle error
            }
        }
        
        if let path = Bundle.main.url(forResource: "top_headlines_static", withExtension: "json") {
            let data = try? Data(contentsOf: path)
            let model = try? JSONDecoder().decode(News.self, from: data!)
            print(model)
        }
        
        let url = Bundle.main.url(forResource: "top_headlines_static", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: jsonData)
            print(json)
            let model = try? JSONDecoder().decode(News.self, from: jsonData)
            print(model)
            
//            if let question1 = json.first?[0] {
//                print( question1["link"] as! String)
//            }
//
//            if let question2 = json.first?[1] {
//                print( question2["link"] as! String)
//            }
        }
        catch {
            print(error)
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
