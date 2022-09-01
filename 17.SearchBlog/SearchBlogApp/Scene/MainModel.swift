//
//  MainModel.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/09/01.
//

import RxSwift

struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.localizedDescription
    }
    
    func getCellData(_ value: DKBlog) -> [BlogData] {
        return value.documents
            .map { doc in
                let thumbnailURL = URL(string: doc.thumbnail ?? "")
                return BlogData(
                    title: doc.name,
                    description: doc.title,
                    thumbnailURL: thumbnailURL,
                    dateTime: doc.dateTime)
            }
    }
    
    func sort(by type: MainViewController.AlertAction, of data: [BlogData]) -> [BlogData] {
        switch type {
        case .title:
            return data.sorted {
                $0.title ?? "" < $1.title ?? ""
            }
        case .dateTime:
            return data.sorted {
                $0.dateTime ?? Date() > $1.dateTime ?? Date()
            }
        default:
            return data
        }
    }
}
