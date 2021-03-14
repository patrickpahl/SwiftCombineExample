//
//  MovieSearch.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import Foundation

struct MovieSearchResponse: Codable {
    let searchType: String
    let expression: String
    let results: [MovieSearch]
    let errorMessage: String
}

struct MovieSearch: Codable {
    let id: String
    let resultType: String
    let image: String
    let title: String
    let description: String
}
