//
//  MainViewModel.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2022/12/26.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    
    // subViewModels
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
    // viewModel에서 view로 전달될 데이터
    // center롤 세팅해주는 이벤트
    let setMapCenter: Signal<MTMapPoint>
    // 에러 메세지 전달
    let errorMessage: Signal<String>
    
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    // view에서 viewModel로 전달될 데이터
    // 현재위치, 맵의 중앙지점, poiItem선택, mapViewError
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    let documentData = PublishSubject<[KLDocument?]>()
    
    init() {
        // MARK: - 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map { data -> MTMapPoint in
                guard let data = data,
                      let lon = Double(data.x),
                      let lat = Double(data.y) else {
                    return MTMapPoint()
                }
                
                let geoCoord = MTMapPointGeo(latitude: lat, longitude: lon)
                return MTMapPoint(geoCoord: geoCoord)
            }
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                [
                    selectDetailListItem,
                    currentLocation.take(1),
                    moveToCurrentLocation
                ]
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = Driver.just([])
        
        scrollToSelectedLocation = selectPOIItem
            .map{ $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}
