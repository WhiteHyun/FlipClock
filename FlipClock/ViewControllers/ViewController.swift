//
//  ViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import Combine
import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
  
  weak var coordinator: MainCoordinator?
  
  private lazy var clockView = FlipClockView()
  private var subscriptions = Set<AnyCancellable>()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    binding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    clockView.start()
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    clockView.stop()
  }
}

// MARK: - Configuration

extension ViewController {
  
  private func configure() {
    view.addSubview(clockView)
    
    clockView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "gearshape.fill"),
      style: .done,
      target: self,
      action: #selector(settingButtonDidTapped)
    )
    navigationController?.navigationBar.tintColor = .label
  }
  
  private func binding() {
    UserDefaults.standard
      .publisher(for: \.backgroundColorTheme)
      .sink { [weak self] in
        self?.view.backgroundColor = .init(rgb: $0)
      }
      .store(in: &subscriptions)
  }
  
  
  @objc func settingButtonDidTapped() {
    coordinator?.moveToSetting()
  }
}
