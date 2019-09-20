//
//  HeadlineViewController.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 19/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class HeadlineViewController: UIViewController {

    var article: Article!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var headlineImage: CustomImageView!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var favouritesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupButtonTitle()
    }
    
    private func setupUI() {
        titleLabel.text = article.title
        headlineImage.downloadImage(from: article.urlToImage ?? "")
        contentLabel.text = article.content
        descriptionLabel.text = article.articleDescription
    }
    
    private func setupButtonTitle() {
        if article.isSaved {
            print("Remove from Favorites")
            self.favouritesButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            print("Save to Favorites")
            self.favouritesButton.setTitle("Save to Favorites", for: .normal)
        }
    }

    @IBAction private func saveToFavorites(_ sender: Any) {
        if article.isSaved {
            article.delete { [weak self] in
                DispatchQueue.main.async {
                    self?.setupButtonTitle()
                }
            }
        } else {
            article.save { [weak self] in
                DispatchQueue.main.async {
                    self?.setupButtonTitle()
                }
            }
        }
    }
    
//    func saveArticle() {
//        let container = try! Container()
//        try! container.write { transaction in
//            transaction.add(article)
//            
//            setupButtonTitle()
//        }
//    }
//    
//    func deleteArticle() {
//        let container = try! Container()
//        try! container.write { transaction in
//            transaction.delete(article)
//            
//            setupButtonTitle()
//        }
//    }
}
