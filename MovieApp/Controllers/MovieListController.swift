//
//  ViewController.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/08.
//

import UIKit

class MovieListController: UIViewController {
  //MARK: - Property
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(MovieListCell.self, forCellReuseIdentifier: "MovieListCell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 160
    return tableView
  }()
  
  var searchBar: UISearchBar!
  var movieList: MovieList?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    configureUI()
    configureNetworkServices()
  }
  
  //MARK: - Private
  private func configureUI() {
    searchBar = UISearchBar()
    searchBar.placeholder = "Input Movie"
    searchBar.layer.borderWidth = 0.5
    searchBar.layer.borderColor = UIColor.systemGray4.cgColor
    self.navigationItem.titleView = searchBar
    
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
    ])
  }
  
  private func configureNetworkServices() {
    NetworkServices().getAPI { [weak self] movieList in
      if let movieList = movieList {
        self?.movieList = movieList
      }
    }
  }
  
  private func dateFormatting(dateString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    let isoDate = isoFormatter.date(from: dateString)!
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일"
    
    let result = formatter.string(from: isoDate)
    return result
  }
}

extension MovieListController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList?.results.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
      return UITableViewCell()
    }
    
    if let movie = movieList?.results[indexPath.row] {
      cell.titleLabel.text = movie.trackName
      cell.descriptionLabel.text = movie.shortDescription
      cell.dateLabel.text = dateFormatting(dateString: movie.date)
      cell.priceLabel.text = "\(movie.trackPrice!)USD"
      if let hasUrl = movie.imageUrl {
        NetworkServices().loadImage(urlString: hasUrl) { image in
          DispatchQueue.main.async {
            cell.thumbnailImage.image = image
          }
        }
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.modalPresentationStyle = .fullScreen
    detailVC.movieInfo = movieList?.results[indexPath.row]
    present(detailVC, animated: true)
  }
  
}

