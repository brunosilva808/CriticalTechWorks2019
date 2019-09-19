//
//  TableViewCell.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    static let nibName = "HeadlineTableViewCell"
    static let cellIdentifier = "cellId"
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var headlineImage: CustomImageView!
    
    func setup(article: Article) {
        self.titleLabel?.text = article.title
        self.headlineImage.downloadImage(from: article.urlToImage)
    }
    
}
