//
//  Repository.swift
//  GithubRepoList
//
//  Created by Mac on 2022/08/05.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String
    let stargazerCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazerCount = "stargazers_count"
    }
}
