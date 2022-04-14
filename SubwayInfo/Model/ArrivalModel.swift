//
//  ArrivalModel.swift
//  SubwayInfo
//
//  Created by Mac on 2022/04/14.
//

import Foundation

struct ArrivalModel: Codable {
    let arrivalList: [ArrivalInfo]
    
    enum CodingKeys: String, CodingKey {
        case arrivalList = "realtimeArrivalList"
    }
}

struct ArrivalInfo: Codable {
    let direction: String
    let arrivalMsg1: String
    let arrivalMsg2: String
    
    enum CodingKeys: String, CodingKey {
        case direction = "trainLineNm"
        case arrivalMsg1 = "arvlMsg2"
        case arrivalMsg2 = "arvlMsg3"
    }
}
