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
    let close = UIButton(frame: .zero)
    close.setTitle("Close", for: .normal)
    close.translatesAutoresizingMaskIntoConstraints = false
    return close
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  //MARK: - Private
  private func configureUI() {
    
  }
}
