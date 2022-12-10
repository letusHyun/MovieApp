//
//  MovieListCell.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/09.
//

import UIKit

class MovieListCell: UITableViewCell {
  
  //MARK: - Property
  let thumbnailImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "sun.min"))
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let title = UILabel()
    title.textColor = .label
    title.font = .systemFont(ofSize: 20, weight: .bold)
    title.numberOfLines = 0
    title.text = "Title"
    return title
  }()
  
  let dateLabel: UILabel = {
    let date = UILabel()
    date.textColor = .label
    date.font = .systemFont(ofSize: 16)
    date.text = "xxxx년 xx월 xx일"
    return date
  }()
  
  let priceLabel: UILabel = {
    let price = UILabel()
    price.textColor = .label
    price.font = .systemFont(ofSize: 18, weight: .bold)
    price.text = "\(99.99)USD"
    price.textAlignment = .right
    return price
  }()
  
  let descriptionLabel: UILabel = {
    let description = UILabel()
    description.textColor = .systemGray
    description.font = .systemFont(ofSize: 17)
    description.numberOfLines = 0
    description.text = "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"
    return description
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  //MARK: - private
  private func configure() {
    
    contentView.addSubview(thumbnailImage)
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(priceLabel)
    
    thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      thumbnailImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      thumbnailImage.widthAnchor.constraint(equalToConstant: 100),
      thumbnailImage.heightAnchor.constraint(equalToConstant: 140),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5),
      
      dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      dateLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
      
      descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -5),
      
      priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
//    descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//    priceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

