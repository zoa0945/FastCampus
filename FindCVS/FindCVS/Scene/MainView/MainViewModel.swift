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
    
    private let documentData = PublishSubject<[KLDocument]>()
    
    init(model: MainModel = MainModel()) {
        // MARK: - 네트워크 통신으로 데이터 불러오기
        let cvsLocationDataResult = mapCenterPoint
            .flatMapLatest(model.getLocation)
            .share()
        
        let cvsLocationDataValue = cvsLocationDataResult
            .compactMap { data -> LocationData? in
                guard case let .success(value) = data else {
                    return nil
                }
                return value
            }
        
        let cvsLocationDataError = cvsLocationDataResult
            .compactMap { data -> String? in
                switch data {
                case let .success(data) where data.documents.isEmpty:
                    return """
                    500m 근방에 이용 가능한 편의점이 없습니다.
                    지도 위치를 조정해 재검색 해주세요.
                    """
                case let .failure(error):
                    return error.localizedDescription
                default:
                    return nil
                }
            }
        
        cvsLocationDataValue
            .map { $0.documents }
            .bind(to: documentData)
            .disposed(by: disposeBag)
        
        // MARK: - 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map { data -> MTMapPoint in
                guard let lon = Double(data.x),
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
        
        errorMessage = Observable
            .merge(
                cvsLocationDataError,
                mapViewError.asObservable()
            )
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = documentData
            .map(model.documentToCellData)
            .asDriver(onErrorDriveWith: .empty())
        
        documentData
            .map { !$0.isEmpty }
            .bind(to: detailListBackgroundViewModel.shouldHideStatusLabel)
            .disposed(by: disposeBag)
        
        scrollToSelectedLocation = selectPOIItem
            .map{ $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}
