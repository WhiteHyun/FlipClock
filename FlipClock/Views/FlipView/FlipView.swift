//
//  FlipView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class FlipView: UIView {

  // MARK: - Properties

  private lazy var item = FlipItem()

  private lazy var line = UIView()

  var time: String = "" {
    didSet {
      item.viewModel.text.accept(time)
    }
  }

  private let disposeBag = DisposeBag()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    binding()
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
      make.height.equalTo(3)
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }

  private func binding() {
    UserDefaults.standard.rx
      .observeWeakly(Int.self, "backgroundColorTheme")
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] in
        self?.line.backgroundColor = .init(rgb: $0)
      })
      .disposed(by: disposeBag)
  }
}
