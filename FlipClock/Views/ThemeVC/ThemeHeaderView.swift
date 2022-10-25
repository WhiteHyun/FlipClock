//
//  ThemeHeaderView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/10/12.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class ThemeHeaderView: UITableViewHeaderFooterView {

  static let id = "ThemeHeaderView"
  private let disposeBag = DisposeBag()

  private let clockBackgroundView = UIView().then {
    $0.layer.shadowRadius = 5
    $0.layer.shadowOpacity = 0.4
    $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    $0.layer.shadowColor = UIColor.lightGray.cgColor
    $0.clipsToBounds = false
    $0.layer.cornerRadius = 15
  }

  private let containerView = UIStackView().then {
    $0.alignment = .center
    $0.distribution = .fillEqually
    $0.spacing = 10
  }

  private let exampleView = [FlipView]().with {
    for _ in 0..<3 {
      let view = FlipView()
      $0.append(view)
    }
  }

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupLayouts()
    setupConstraints()
    setupStyles()
    bind()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayouts() {
    self.addSubview(clockBackgroundView)
    self.clockBackgroundView.addSubview(containerView)
    exampleView.forEach {
      containerView.addArrangedSubview($0)
    }
  }

  private func setupConstraints() {

    clockBackgroundView.snp.makeConstraints { make in
      make.verticalEdges.equalToSuperview().inset(30)
      make.horizontalEdges.equalToSuperview().inset(10)
    }

    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }

    exampleView.forEach { view in
      view.snp.makeConstraints { make in
        make.height.equalTo(view.snp.width)
      }
    }
  }

  private func setupStyles() {
    var config = UIBackgroundConfiguration.listPlainHeaderFooter()
    config.backgroundColor = .clear
    self.backgroundConfiguration = config
  }

  private func bind() {
      Theme.currentTheme
        .map { UIColor(rgb: $0.colors.background) }
        .bind(to: self.clockBackgroundView.rx.backgroundColor)
        .disposed(by: disposeBag)
  }
}
