//
//  NetworkServices.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/10.
//

import Foundation

class NetworkServices {
  func getAPI(completion: @escaping (MovieList?) -> Void) {
    //세션 생성, 환경 설정
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    
    //component
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
    
    
    let termQuery = URLQueryItem(name: "term", value: "marvel")
    let mediaQuery = URLQueryItem(name: "media", value: "movie")
    
    urlComponents.queryItems?.append(termQuery)
    urlComponents.queryItems?.append(mediaQuery)
    
    let url = urlComponents.url!
  
    let request = URLRequest(url: url)
    let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
      let successRange = 200..<300
      
      guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
        return
      }
      
      guard let resultData = data else {
        return
      }
      
      do {
        let movieList = try JSONDecoder().decode(MovieList.self, from: resultData)
        completion(movieList)
      } catch {
        print("--> error: \(error.localizedDescription)")
        completion(nil)
      }
    }
    
    dataTask.resume()
  }
}
