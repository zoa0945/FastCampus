//
//  MainViewController.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2022/12/25.
//

import UIKit
import CoreLocation
import RxCocoa
import RxSwift
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    let mapView = MTMapView()
    let currentLocationButton = UIButton()
    let detailList = UITableView()
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        bind(viewModel)
        attribute()
        layout()
    }
    
    func bind(_ viewModel: MainViewModel) {
        currentLocationButton.rx.tap
            .bind(to: viewModel.currentLocationButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "내 주변 편의점 찾기"
        view.backgroundColor = .systemBackground
        
        mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.backgroundColor = .systemBackground
        currentLocationButton.layer.cornerRadius = 20
    }
    
    private func layout() {
        [
            mapView,
            currentLocationButton,
            detailList
        ].forEach {
            view.addSubview($0)
        }
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.centerY).offset(100)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(detailList.snp.top).offset(-12)
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(40)
        }
        
        detailList.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(mapView.snp.bottom)
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    // didChangeAuthorization: 어떠한 상황에 사용자가 위치 서비스를 사용하도록 동의했는지 동의하지 않았다면 어떤 설정을 하도록 함
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
                .authorizedWhenInUse,
                .notDetermined:
            return
        default:
            // TODO: - viewModel.mapViewError.accept()
            return
        }
    }
}

extension MainViewController: MTMapViewDelegate {
    // updateCurrentLocation: 현재 위치를 계속 업데이트 해줌
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        #if DEBUG
        // TODO: - viewModel.currentLocation.accept()
                
        #else
        // TODO: - viewModel.currentLocation.accept(location)
        
        #endif
    }
    
    // finishMapMoveAnimation: 맵의 이동이 끝났을 때 마지막의 centerpoint를 전달해줌
    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
        // TODO: - viewModel.mapCenterPoint.accept(mapCenterPoint)
    }
    
    // selectedPOIItem: 핀 표시된 지점을 tap할 때 마다 해당 지점의 MTMapPOIItem을 전달해줌
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        // TODO: - viewModel.selectPOIItem.accept(poiItem)
        return false
    }
    
    // failedUpdatingCurrentLocationWithError: 제대로 된 현재 위치를 받아오지 못했을 때 에러를 발생시킴
    func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
        // TODO: - viewModel.mapViewError.accept(error.localizedDescription)
    }
}
