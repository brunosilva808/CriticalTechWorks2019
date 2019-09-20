//
//  CustomImageView.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    let imageCache = NSCache<NSString, UIImage>()
    var imageUrlString: String?
    
    func downloadImage(from urlString: String) {
        
        imageUrlString = urlString
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        
                        guard let imageToCache = UIImage(data: data) else {
                            return
                        }
                        
                        if self?.imageUrlString == urlString {
                            self?.image = imageToCache
                        }
                        
                        self?.imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    }
                }
            }.resume()
        }
    }
    
}
