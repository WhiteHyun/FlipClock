//
//  HomeViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class HomeViewController: BaseViewController {

  private lazy var clockView = FlipClockView()

  // MARK: - Life Cycle

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

  override func setupLayouts() {
    super.setupLayouts()

    view.addSubview(clockView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "gearshape.fill"),
      style: .done,
      target: self,
      action: #selector(settingButtonDidTapped)
    )
  }

  override func setupConstraints() {
    super.setupConstraints()

    clockView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
    }
  }

  override func setupStyles() {
    super.setupStyles()
    navigationController?.navigationBar.tintColor = .label
  }

  override func bind() {
    super.bind()

    Theme.currentTheme
      .map { UIColor(rgb: $0.colors.background) }
      .bind(to: self.view.rx.backgroundColor)
      .disposed(by: disposeBag)
  }

  @objc func settingButtonDidTapped() {
    guard let coordinator = coordinator as? HomeCoordinator else { return }
      coordinator.moveToSetting()
  }
}
