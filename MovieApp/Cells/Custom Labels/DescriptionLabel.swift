//
//  DescriptionLabel.swift
//  MovieApp
//
//  Created by SeokHyun on 2022/12/11.
//

import Foundation
import UIKit

class DescriptionLabel: UILabel {
  
  private var padding = UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1) //custom padding 설정
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //label의 text값이 그려질때 rect에 관한 값을 수정하고 싶을때 해당 메소드를 override하여 사용
  override func drawText(in rect: CGRect) {
    //사용 방법은 super.drawText(in:)에 변경된 rect값을 인수로 주어 반영
    super.drawText(in: rect.inset(by: padding))
  }
  
  //padding을 변경한다고 intrinsicContentSize가 변경되지 않기 때문에, label.text의 내용이 잘리는 현상 발생하거나 top, bottom이 적용 안된 상태로 적용 -> intrinsicContentSize 업데이트 필요
  override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.width = padding.left + padding.right + contentSize.width
    contentSize.height = padding.top + padding.bottom + contentSize.height
    return contentSize
  }
}
