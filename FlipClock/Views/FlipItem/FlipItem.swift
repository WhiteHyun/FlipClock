//
//  FlipItem.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import Combine
import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class FlipItem: UIView {

  // MARK: - Properties

  private let label = UILabel().then {
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 90, weight: .bold)
    $0.text = "00"
  }

  let viewModel = FlipitemViewModel()
  let animationViewModel = FlipAnimationViewModel()

  private var previousTextTopView = UIView()
  private var previousTextBottomView = UIView()
  private var nextTextBottomView = UIView()

  var disposeBag = DisposeBag()

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

// MARK: - Layout Cycle

extension FlipItem {

  override func layoutSubviews() {
    super.layoutSubviews()
    configureLabelStyles()
  }
}

// MARK: - Configuration

extension FlipItem {

  private func configure() {

    // 모서리 둥글게 설정
    layer.cornerRadius = 15

    // layout 세팅
    addSubview(label)

    label.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    backgroundColor = UserDefaults.standard.isThemeConfigured
    ? .init(rgb: UserDefaults.standard.clockBackgroundColorTheme)
    : .black
  }

  /// 플립 시계의 폰트 크기를 상위뷰에 맞추어 설정합니다.
  private func configureLabelStyles() {
    label.clipsToBounds = false // stackview 회전할 때 true값이 됨 (이유 모름)
    label.font = .systemFont(ofSize: bounds.width * 0.6, weight: .bold)
  }

  private func binding() {

    UserDefaults.standard.rx
      .observeWeakly(Int.self, "clockBackgroundColorTheme")
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] in
        self?.backgroundColor = .init(rgb: $0)
      })
      .disposed(by: disposeBag)

    UserDefaults.standard.rx
      .observeWeakly(Int.self, "textColorTheme")
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] in
        self?.label.textColor = .init(rgb: $0)
      })
      .disposed(by: disposeBag)

    viewModel.text
      .skip(1)
      .filter { [unowned self] in self.label.text != $0 }
      .map { [unowned self] in viewModel.createSnapshots(self, label: self.label, newText: $0) }
      .subscribe(onNext: { [unowned self] in
        self.previousTextTopView = $0.previousTopView
        self.previousTextBottomView = $0.previousBottomView
        self.nextTextBottomView = $0.nextBottomView

        [$0.previousTopView, $0.previousBottomView, $0.nextBottomView].forEach {
          self.label.addSubview($0)
        }
        self.startAnimations()
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - Animations

extension FlipItem {
  private func startAnimations() {
    // 윗 부분과 아랫부분 글자의 그림자 애니메이션을 추가합니다.
    animationViewModel.shadowAnimation(previousTextTopView, alpha: 0.3)
    animationViewModel.shadowAnimation(previousTextBottomView, alpha: 0.2)

    animationViewModel.flipAnimation(previousTextTopView, type: .top) { [unowned self] in
      self.nextTextBottomView.isHidden = false
      self.animationViewModel.flipAnimation(self.nextTextBottomView, type: .bottom) {
        self.stopAnimations()
      }
    }

    animationViewModel.bottomShadowAnimation(previousTextBottomView)
  }

  private func stopAnimations() {
    nextTextBottomView.layer.removeAllAnimations()
    nextTextBottomView.removeFromSuperview()

    previousTextTopView.layer.removeAllAnimations()
    previousTextTopView.removeFromSuperview()

    previousTextBottomView.layer.removeAllAnimations()
    previousTextBottomView.removeFromSuperview()

    label.layer.sublayers = nil
  }
}
