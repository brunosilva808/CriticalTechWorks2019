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
    }
    
    private func setupUI() {
        titleLabel.text = article.title
        headlineImage.downloadImage(from: article.urlToImage)
        contentLabel.text = article.content
        descriptionLabel.text = article.articleDescription
    }

    @IBAction func saveToFavorites(_ sender: Any) {
    }
}
