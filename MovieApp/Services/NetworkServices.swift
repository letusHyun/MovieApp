//
//  NetworkServices.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/10.
//

import Foundation
import UIKit

class NetworkServices {
  
  
  func getAPI(_ term: String, completion: @escaping (MovieList?) -> Void) {
//    //세션 생성, 환경 설정
//    let sessionConfig = URLSessionConfiguration.default
//    let session = URLSession(configuration: sessionConfig)
    
    //component
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
    let termQuery = URLQueryItem(name: "term", value: term)
    let mediaQuery = URLQueryItem(name: "media", value: "movie")
    urlComponents.queryItems = [termQuery, mediaQuery]
    
    let url = urlComponents.url!
    let request = URLRequest(url: url)
    
    //URLSession.shared 로 접근 시 URLSessionConfiguration.default로 적용됨
    URLSession.shared.dataTask(with: request) { data, response, error in
      let successRange = 200..<300

      guard error == nil else { return }
      guard let data = data else { return }
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
      if !successRange.contains(statusCode) {
        return
      }
      
      let decoder = JSONDecoder()
      let movieList = try? decoder.decode(MovieList.self, from: data)
      completion(movieList)
    }.resume()
  }
  
  func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
    let url = URL(string: urlString)!
    URLSession.shared.dataTask(with: url) { data, response, error in
      let successRange = 200..<300
      guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
        completion(nil)
        return
      }
      
      if let hasData = data {
        completion(UIImage(data: hasData))
        return
      }
      
      completion(nil)
    }.resume()
  }
}
