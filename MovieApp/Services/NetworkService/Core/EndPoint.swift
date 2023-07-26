//
//  EndPoint.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

public enum NetworkMethod: String {
    case get = "GET"
    case post = "Post"
}

public protocol Endpoint {
    var url: String { get }
    var method: NetworkMethod { get }
}
