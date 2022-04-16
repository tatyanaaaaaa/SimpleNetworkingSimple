//
//  NewsModel.swift
//  SimpleNetworkingSimple
//
//  Created by Tatiana Sosina on 16.04.2022.
//

import Foundation

struct NewsModel: Codable {

    let version: String
    let newsSites: [String]
}
