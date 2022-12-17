//
//  SearchBlogNetwork.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/16.
//

import RxSwift
import Foundation

// ErrorHandling: ex) 네트워크 연결, 잘못된 입력, API&HTTP 에러 등
// catch: 기본값(defaultValue)으로 복구
// - catch(_ Handler:) -> closure를 받아서 다른 Observable로 반환
// - catchAndReturn(_ element:) -> Error를 무시하고 이전에 선언해둔 Observable을 반환
// retry: 제한적 또는 무제한으로 재시도
// - retry() -> Error발생 시 무제한으로 재시도
// - retry(_ maxAttemptCount:) -> maxAttemptCount만큼 반복 후 Error를 방출
enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 305802a3774a30ef839df3cd9d86062f", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
}
