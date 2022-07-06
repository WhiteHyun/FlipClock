//
//  FlipClockView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

class FlipClockView: UIView {
  
  
  // MARK: - Properties
  
  private lazy var container = UIStackView().then {
    $0.alignment = .center
    $0.axis = .vertical
    $0.distribution = .fillEqually
    $0.spacing = 10
  }
  
  private lazy var hourItem = FlipView().then {
    $0.type = .hours
  }
  
  private lazy var minuteItem = FlipView().then {
    $0.type = .minutes
  }
  
  private lazy var secondItem = FlipView().then {
    $0.type = .seconds
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

extension FlipClockView {
  
  func configure() {
    
    addSubview(container)
    
    [hourItem, minuteItem, secondItem].forEach {
      container.addArrangedSubview($0)
    }
    
    container.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    
    [hourItem, minuteItem, secondItem].forEach { view in
      view.snp.makeConstraints { make in
        make.width.equalTo(view.snp.height)
      }
    }
  }
  
}
