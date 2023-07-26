//
//  DispatchQueueType.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

protocol DispatchQueueType {
    func async(work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(work: @escaping @convention(block) () -> Void) {
        async(execute: work)
    }
}
