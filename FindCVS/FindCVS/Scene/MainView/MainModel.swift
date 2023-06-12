//
//  MainModel.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2023/06/11.
//

import Foundation
import RxSwift

class MainModel {
    let localNetwork: LocalNetwork
    
    init(localNetwork: LocalNetwork = LocalNetwork()) {
        self.localNetwork = localNetwork
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return localNetwork.getLocation(by: mapPoint)
    }
    
    func documentToCellData(_ data: [KLDocument]) -> [DetailListCellData] {
        return data.map {
            let address = $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName
            let point = documentToMTMapPoint($0)
            return DetailListCellData(placeName: $0.placeName, address: address, distance: $0.distance, point: point)
        }
    }
    
    func documentToMTMapPoint(_ doc: KLDocument) -> MTMapPoint {
        let lat = Double(doc.x) ?? .zero
        let lon = Double(doc.y) ?? .zero
        
        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: lat, longitude: lon))
    }
}
