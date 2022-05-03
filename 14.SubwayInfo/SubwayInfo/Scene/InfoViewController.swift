//
//  InfoViewController.swift
//  SubwayInfo
//
//  Created by Mac on 2022/04/13.
//

import UIKit
import SnapKit
import Alamofire

class InfoViewController: UIViewController {
    private let station: StationInfo
    private var arrivalList: [ArrivalInfo] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func fetchData() {
        let stationName = station.stationName
        let url = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))"
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: ArrivalModel.self) { [weak self] response in
                self?.refreshControl.endRefreshing()
                guard case .success(let data) = response.result else { return }
                
                self?.arrivalList = data.arrivalList.sorted { $0.direction < $1.direction }
                self?.collectionView.reloadData()
                print(data.arrivalList)
            }
            .resume()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCollectionViewCell")
        
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = station.stationName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    }
    
    init(station: StationInfo) {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        
        let arrivalInfo = arrivalList[indexPath.row]
        
        cell.setup(arrivalInfo)
        
        return cell
    }
}
