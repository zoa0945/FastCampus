//
//  AlertActionConvertable.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/15.
//

import UIKit

protocol AlertActionConvertable {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
