//
//  ViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class ViewController: UIViewController {

  weak var coordinator: MainCoordinator?

  private lazy var clockView = FlipClockView()
  private let disposeBag = DisposeBag()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    binding()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    clockView.start()
    UIApplication.shared.isIdleTimerDisabled = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    clockView.stop()
    UIApplication.shared.isIdleTimerDisabled = false
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
    Theme.currentTheme
      .map { UIColor(rgb: $0.colors.background) }
      .bind(to: self.view.rx.backgroundColor)
      .disposed(by: disposeBag)
  }

  @objc func settingButtonDidTapped() {
    coordinator?.moveToSetting()
  }
}
