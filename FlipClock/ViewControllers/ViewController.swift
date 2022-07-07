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
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 1)
    view.backgroundColor = .lightGray
    configure()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    label.start()
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    label.stop()
  }
}

// MARK: - Configuration

extension ViewController {
  
  private func configure() {
    view.addSubview(label)
    
    label.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "gearshape.fill"),
      style: .done,
      target: self,
      action: #selector(goToSetting)
    )
    navigationController?.navigationBar.tintColor = .label
  }
  
  
  @objc func goToSetting() {
    coordinator?.moveToSetting()
  }
  
}
