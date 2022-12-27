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
    
    // viewModel에서 view로 전달될 데이터
    // center롤 세팅해주는 이벤트
    let setMapCenter: Signal<MTMapPoint>
    // 에러 메세지 전달
    let errorMessage: Signal<String>
    
    // view에서 viewModel로 전달될 데이터
    // 현재위치, 맵의 중앙지점, poiItem선택, mapViewError
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    
    let currentLocationButtonTapped = PublishRelay<Void>()
    
    init() {
        // MARK: - 지도 중심점 설정
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                [
                    currentLocation.take(1),
                    moveToCurrentLocation
                ]
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
    }
}
