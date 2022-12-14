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
    let imageView = UIImageView(frame: .zero)
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let title = UILabel()
    title.textColor = .black
    title.font = .systemFont(ofSize: 18, weight: .bold)
    title.numberOfLines = 2
    title.text = "Title"
    return title
  }()
  
  let dateLabel: UILabel = {
    let date = UILabel()
    date.textColor = .black
    date.font = .systemFont(ofSize: 13)
    date.text = "xxxx년 xx월 xx일"
    return date
  }()
  
  let priceLabel: UILabel = {
    let price = UILabel()
    price.textColor = .black
    price.font = .systemFont(ofSize: 14, weight: .bold)
    price.text = "\(99.99)USD"
    price.textAlignment = .right
    return price
  }()
  
  let descriptionLabel: UILabel = {
    let description = UILabel()
    description.textColor = .systemGray
    description.font = .systemFont(ofSize: 13)
    description.numberOfLines = 0
    description.text = "description"
    
    return description
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    selectionStyle = .none
    setAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Override
  //Q: image만 초기화 해주는 이유가 있을까?
  override func prepareForReuse() {
    super.prepareForReuse()
    
    thumbnailImage.image = nil
  }
  
  // Cell's color changing with animation
    // Have to: self.selectionStyle = .none
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    
    guard self.isHighlighted else { return }
  
    UIView.animate(
      withDuration: 0.2,
      animations: { self.backgroundColor = .systemGray5 },
      completion: { _ in
        UIView.animate(withDuration: 0.05) {
          self.backgroundColor = .white
        }
      })
  }
  
  //MARK: - private
  private func setAutoLayout() {
    
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
      thumbnailImage.widthAnchor.constraint(equalToConstant: 70),
      thumbnailImage.heightAnchor.constraint(equalToConstant: 120),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5),
      
      dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      dateLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
      
      descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: priceLabel.topAnchor, constant: -5),
      
      priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
    
    descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
  }
}
