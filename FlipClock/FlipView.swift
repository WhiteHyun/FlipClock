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
  
  // MARK: - Properties
  
  var type: FlipItemType = .seconds
  
  lazy var item = FlipItem()
  
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Configuration

extension FlipView {
  
  private func configure() {
    addSubview(item)
    item.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    let line = UIView().then {
      $0.backgroundColor = .lightGray
    }
    addSubview(line)
    line.snp.makeConstraints { make in
      make.height.equalTo(5)
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview()
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
