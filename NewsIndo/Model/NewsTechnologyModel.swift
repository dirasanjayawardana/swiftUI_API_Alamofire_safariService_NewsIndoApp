//
//  NewsTechnologyModel.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

struct NewsTechnologyModel: Codable {
    let message: String
    let total: Int
    let data: [ArticleTechnology]
}

struct ArticleTechnology: Codable, Identifiable {
    var id: String {link}
    let title: String
    let link: String
    let contentSnippet, isoDate: String
    let image: ImageTechnology
}

struct ImageTechnology: Codable {
    let small, large: String
}
