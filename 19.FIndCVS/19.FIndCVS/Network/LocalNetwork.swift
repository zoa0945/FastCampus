//
//  LocalNetwork.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2023/06/11.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = SearchAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 27d78be6ef4d52fd65b346222394ba99", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork))) }
            .asSingle()
    }
}
