//
//  DetailViewController.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/12.
//

import UIKit

class DetailViewController: UIViewController {
  //MARK: - Property
  let closeButton: UIButton = {
    var configuration = UIButton.Configuration.tinted()
    configuration.title = "Close"
    let close = UIButton(configuration: configuration)
    close.translatesAutoresizingMaskIntoConstraints = false
    return close
  }()
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemCyan //will Delete
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let playButton: UIButton = {
    var configuration = UIButton.Configuration.tinted()
    configuration.title = "Play"
    let play = UIButton(configuration: configuration)
    play.translatesAutoresizingMaskIntoConstraints = false
    return play
  }()
  
  let stopButton: UIButton = {
    var configuration = UIButton.Configuration.tinted()
    configuration.title = "Stop"
    let stop = UIButton(configuration: configuration)
    stop.translatesAutoresizingMaskIntoConstraints = false
    return stop
  }()
  
  let titleLabel: UILabel = {
    let title = UILabel()
    title.text = "NULL"
    title.font = .systemFont(ofSize: 20, weight: .bold)
    title.numberOfLines = 0
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  let descriptionLabel: UILabel = {
    let description = UILabel()
    description.text = "NUll"
    description.font = .systemFont(ofSize: 17)
    description.numberOfLines = 0
    description.textColor = .systemGray
    description.translatesAutoresizingMaskIntoConstraints = false
    return description
  }()
  
  private let scrollView: UIScrollView = { //for descriptionLabel
    let scrollView = UIScrollView()
    scrollView.isScrollEnabled = true
    scrollView.indicatorStyle = .black
    scrollView.showsVerticalScrollIndicator = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  var movieInfo: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    buttonsClicked()
  }
  
  //MARK: - Private
  private func configureUI() {
    view.backgroundColor = .white
    if let movie = movieInfo {
      titleLabel.text = movie.trackName
      descriptionLabel.text = movie.longDescription
    }
    setAutoLayout()
  }
  
  private func setAutoLayout() {
    view.addSubview(closeButton)
    view.addSubview(contentView)
    view.addSubview(playButton)
    view.addSubview(stopButton)
    view.addSubview(titleLabel)
    
    view.addSubview(scrollView)
    scrollView.addSubview(descriptionLabel)
    
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      closeButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -30),
      
      contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 200),
      
      playButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
      playButton.trailingAnchor.constraint(equalTo: stopButton.leadingAnchor, constant: -10),
      
      stopButton.topAnchor.constraint(equalTo: playButton.topAnchor),
      stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      
      titleLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30),
      titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
      
      scrollView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
      descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
  
  private func buttonsClicked() {
    closeButton.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
    
  }
  
  @objc func closeBtnClicked() {
    dismiss(animated: true)
  }
}
