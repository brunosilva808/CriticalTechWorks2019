//
//  Suggestion.swift
//  CriticalTechWorks
//
//  Created by Bruno Silva on 02/09/2019.
//

import UIKit

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
