//
//  MockDispatchQueue.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MockDispatchQueue: DispatchQueueType {
    func async(work: @escaping @convention(block) () -> Void) {
        work()
    }
}
