//
//  FlipView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

import SnapKit
import Then


class FlipView: UIView {
  
  var type: FlipItemType = .seconds
  
  lazy var item = FlipItem()
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension FlipView {
  
  private func configure() {
    addSubview(item)
    item.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

// MARK: - Enums

extension FlipView {
  
  enum FlipItemType {
    
    case hours
    case minutes
    case seconds
  }
  
}
