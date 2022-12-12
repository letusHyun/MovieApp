//
//  NetworkServices.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/10.
//

import Foundation
import UIKit

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
    
    //Q: [weak self] warning?
    let dataTask = session.dataTask(with: request) { data, response, error in
      let successRange = 200..<300
      
      guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
        return
      }
      
      guard let resultData = data else {
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let movieList = try decoder.decode(MovieList.self, from: resultData)
        completion(movieList)
      } catch {
        print("--> error: \(error.localizedDescription)")
        completion(nil)
      }
    }
    
    dataTask.resume()
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
