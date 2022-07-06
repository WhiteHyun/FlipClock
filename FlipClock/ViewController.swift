//
//  ViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
  
  weak var coordinator: MainCoordinator?
  
  private lazy var label = FlipClockView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 1)
    view.backgroundColor = .lightGray
    configure()

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    label.start()
  }
}

// MARK: - Configuration

extension ViewController {
  
  private func configure() {
    view.addSubview(label)
    
    label.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
}
