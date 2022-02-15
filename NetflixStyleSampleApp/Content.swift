//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by Mac on 2022/02/15.
//

import UIKit

struct Content: Codable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Codable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Codable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}
