//
//  ViewController.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/08.
//

import UIKit

class MovieListController: UIViewController {
  //MARK: - Property
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(MovieListCell.self, forCellReuseIdentifier: "MovieListCell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 160
    tableView.delegate = self
    tableView.dataSource = self
    
    return tableView
  }()
  
  var searchBar: UISearchBar!
  var movieList: MovieList?
  let networkServices = NetworkServices()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    configureUI()
    
  }
  
  //MARK: - Private
  private func configureUI() {
    searchBar = UISearchBar()
    searchBar.delegate = self
    
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
  
  private func dateFormatting(dateString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    let isoDate = isoFormatter.date(from: dateString)!
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MM.dd.yyyy"
    
    let result = formatter.string(from: isoDate)
    return result
  }
}

extension MovieListController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList?.results.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "MovieListCell",
      for: indexPath) as? MovieListCell else {
      return UITableViewCell()
    }
    
    if let movie = movieList?.results[indexPath.row] {
      cell.titleLabel.text = movie.trackName
      cell.descriptionLabel.text = movie.shortDescription
      cell.dateLabel.text = dateFormatting(dateString: movie.date)
      cell.priceLabel.text = "\(movie.trackPrice ?? 0.0)USD"
      
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

//MARK: SearchBarDelegate
extension MovieListController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    networkServices.getAPI(searchBar.text ?? "") { [weak self] movieList in
      
      if let hasMovieList = movieList {
        self?.movieList = hasMovieList
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      }
    }
  }
}
