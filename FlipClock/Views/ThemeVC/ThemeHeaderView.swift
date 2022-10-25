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
    bind()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayouts() {
    addSubview(containerView)
    exampleView.forEach {
      containerView.addArrangedSubview($0)
    }
  }

  private func setupConstraints() {
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(30)
    }

    exampleView.forEach { view in
      view.snp.makeConstraints { make in
        make.height.equalTo(view.snp.width)
      }
    }
  }
  
  private func bind() {
      Theme.currentTheme
        .map { UIColor(rgb: $0.colors.background) }
        .subscribe(onNext: { [weak self] in
          var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
          backgroundConfig.backgroundColor = $0
          self?.backgroundConfiguration = backgroundConfig
        })
        .disposed(by: disposeBag)
  }
}
