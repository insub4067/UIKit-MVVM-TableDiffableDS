//
//  Models.swift
//  UIKit-Test
//
//  Created by Kim Insub on 2022/11/28.
//

import Foundation

struct Person: Codable, Hashable {
    let name: String
}

struct People: Codable {
    let results: [Person]
}
