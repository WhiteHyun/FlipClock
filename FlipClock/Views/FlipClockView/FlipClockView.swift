//
//  FlipClockView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

import SnapKit
import Then

protocol ClockDelegate {
  
  func start()
  
  func stop()
}


class FlipClockView: UIView {
  
  
  // MARK: - Properties
  
  private lazy var container = UIStackView().then {
    $0.alignment = .center
    $0.axis = .vertical
    $0.distribution = .fillEqually
    $0.spacing = 10
  }
  
  private lazy var hourItem = FlipView()
  
  private lazy var minuteItem = FlipView()
  
  private lazy var secondItem = FlipView()
  
  private var timer: Timer?
  
  let formatter = DateFormatter().then {
    $0.dateFormat = "hh:mm:ss"
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    container.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
  }
  
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
  
  @objc func updateTime() {
    let time = formatter.string(from: .now).split(separator: ":")
    
    
    hourItem.time = String(time[0])
    minuteItem.time = String(time[1])
    secondItem.time = String(time[2])
    
  }
}

// MARK: - ClockDelegate

extension FlipClockView: ClockDelegate {
  func start() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
  }
  
  func stop() {
    timer?.invalidate()
  }
  
  
}
