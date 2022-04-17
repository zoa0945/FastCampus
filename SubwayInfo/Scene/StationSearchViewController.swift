//
//  StationSearchViewController.swift
//  SubwayInfo
//
//  Created by Mac on 2022/04/12.
//

import UIKit
import SnapKit
import Alamofire

class StationSearchViewController: UIViewController {
    private var stations: [StationInfo] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역명을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension StationSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        
        cell.textLabel?.text = station.stationName
        cell.detailTextLabel?.text = station.lineNum
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc = InfoViewController(station: station)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(searchText)
    }
}

extension StationSearchViewController {
    func requestStationName(_ term: String) {
        let url = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(term)"
        
        AF
            .request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationModel.self) { [weak self] response in
                guard case .success(let data) = response.result else {
                    // 에러 처리
                    return
                }
                
                self?.stations = data.stations
                self?.tableView.reloadData()
            }
            .resume()
    }
}
