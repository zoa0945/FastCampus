//
//  Feature.swift
//  AppStoreSample
//
//  Created by Mac on 2022/04/12.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
