//
//  MainModel.swift
//  18.MarketUpload
//
//  Created by zoa0945 on 2022/12/20.
//

import Foundation

class MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title, message: message)
    }
}
