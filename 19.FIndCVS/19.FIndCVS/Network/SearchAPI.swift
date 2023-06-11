//
//  SearchAPI.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2023/06/01.
//

import Foundation

class SearchAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/local/search/category.json"
    
    func getLocation(by mapPoint: MTMapPoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = SearchAPI.scheme
        components.host = SearchAPI.host
        components.path = SearchAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "category_group_code", value: "CS2"),
            URLQueryItem(name: "x", value: "\(mapPoint.mapPointGeo().longitude)"),
            URLQueryItem(name: "y", value: "\(mapPoint.mapPointGeo().latitude)"),
            URLQueryItem(name: "radius", value: "500"),
            URLQueryItem(name: "sort", value: "distance")
        ]
        
        return components
    }
}
