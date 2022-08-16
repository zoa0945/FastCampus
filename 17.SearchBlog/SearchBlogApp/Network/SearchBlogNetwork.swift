//
//  SearchBlogNetwork.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/16.
//

import RxSwift
import Foundation

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
