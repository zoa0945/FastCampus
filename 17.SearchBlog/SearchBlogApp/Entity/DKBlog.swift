//
//  DKBlog.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/16.
//

import Foundation

struct DKBlog: Codable {
    let documents: [DKDocument]
}

struct DKDocument: Codable {
    let name: String?
    let title: String?
    let description: String?
    let thumbnail: String?
    let dateTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case title, thumbnail
        case name = "blogname"
        case description = "contents"
        case dateTime = "datetime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try? values.decode(String?.self, forKey: .name)
        self.title = try? values.decode(String?.self, forKey: .title)
        self.description = try? values.decode(String?.self, forKey: .description)
        self.thumbnail = try? values.decode(String?.self, forKey: .thumbnail)
        self.dateTime = Date.parse(values, key: .dateTime)
    }
}

extension Date {
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date? {
        guard let dateString = try? values.decode(String?.self, forKey: key),
              let date = from(dateString: dateString) else {
            return nil
        }
        
        return date
    }
    
    static func from(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
}
