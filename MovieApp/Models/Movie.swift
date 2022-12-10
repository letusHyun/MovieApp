//
//  Movie.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/10.
//

import Foundation

struct MovieList: Codable {
  let results: [Movie]
}

struct Movie: Codable {
  let trackName: String?
  let date: String?
  let trackPrice: Double?
  let imageUrl: String?
  let shortDescription: String?
  let longDescription: String?
  
  enum CodingKeys: String, CodingKey {
    case trackName
    case date = "releaseDate"
    case imageUrl = "artworkUrl100"
    case trackPrice
    case shortDescription
    case longDescription
  }
}
