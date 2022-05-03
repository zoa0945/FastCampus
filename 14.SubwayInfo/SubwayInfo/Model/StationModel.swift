//
//  StationModel.swift
//  SubwayInfo
//
//  Created by Mac on 2022/04/14.
//

import Foundation

struct StationModel: Codable {
    var stations: [StationInfo] { searchInfo.row }
    let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Codable {
        var row: [StationInfo] = []
    }
}

struct StationInfo: Codable {
    let stationName: String
    let lineNum: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNum = "LINE_NUM"
    }
}
