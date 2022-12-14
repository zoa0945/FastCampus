//
//  ListViewController.swift
//  GithubRepoList
//
//  Created by Mac on 2022/05/12.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UITableViewController {
    private let organization = "ReactiveX"
    
    // 네트워크 통신이 끝난 뒤 결과같이 들어갈 빈 Sequence
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = organization + "'s Repositories"
        
        self.refreshControl = UIRefreshControl()
        guard let refreshControl = self.refreshControl else { return }
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        tableView.rowHeight = 140
    }

    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    // 네트워크 통신을 통해 데이터를 불러온 뒤 Subject에 onNext 이벤트를 발생시키는 함수
    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            // String to URL
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            // URL to URLRequest
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            // URLRequest to Observable
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                // UIKit에서 사용되던 URLSession을 rx로 변환해줌
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            // Data to [String: Any] : Data형태를 JSON 형태의 Dictionary로 Decoding
            .map { _, data -> [[String: Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter { result in
                result.count > 0
            }
            // JSON to Repository : 변환된 Dictionary형태를 Repository로 변환
            .map { objects in
                return objects.compactMap { dic -> Repository? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazerCount = dic["stargazers_count"] as? Int,
                          let language = dic["language"] as? String else {
                        return nil
                    }
                    return Repository(id: id, name: name, description: description, stargazerCount: stargazerCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                guard let self = self else { return }
                self.repositories.onNext(newRepositories)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        
        cell.repo = currentRepo
        
        return cell
    }
}
