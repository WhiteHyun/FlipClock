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
  
  private lazy var item = FlipItem()
  
  private lazy var line = UIView().then {
    $0.backgroundColor = .lightGray
  }
  
  var time: String? {
    didSet {
      item.text = time
    }
  }
  
  
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
    addSubview(line)
    
    item.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    line.snp.makeConstraints { make in
      make.height.equalTo(5)
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }
}
