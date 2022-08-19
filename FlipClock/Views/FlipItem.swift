//
//  FlipItem.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import Combine
import UIKit

import SnapKit
import Then


class FlipItem: UIView {
  
  
  // MARK: - Properties
  
  private let label = UILabel().then {
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 90, weight: .bold)
    $0.text = "00"
  }
  
  let viewModel = FlipitemViewModel()
  let animationViewModel = FlipAnimationViewModel()
  
  /// Flippable label Text
  var text: String? {
    get {
      return label.text
    }
    
    set {
      guard let value = newValue, label.text != newValue else { return }
      updateWithText(value)
      startAnimations()
    }
  }
  
  private var previousTextTopView: UIView!
  private var previousTextBottomView: UIView!
  
  private var nextTextBottomView: UIView!
  
  private var subscriptions = Set<AnyCancellable>()
  
  
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
    
    backgroundColor = UserDefaults.standard.isThemeConfigured ? .init(rgb: UserDefaults.standard.clockBackgroundColorTheme) : .black
  }
  
  
  /// 플립 시계의 폰트 크기를 상위뷰에 맞추어 설정합니다.
  private func configureLabelStyles() {
    label.clipsToBounds = false // stackview 회전할 때 true값이 됨 (이유 모름)
    label.font = .systemFont(ofSize: bounds.width * 0.6, weight: .bold)
  }
  
  private func binding() {
    UserDefaults.standard
      .publisher(for: \.clockBackgroundColorTheme)
      .sink { [weak self] in
        self?.backgroundColor = .init(rgb: $0)
      }
      .store(in: &subscriptions)
    
    UserDefaults.standard
      .publisher(for: \.textColorTheme)
      .sink { [weak self] in
        self?.label.textColor = .init(rgb: $0)
      }
      .store(in: &subscriptions)
  }
}

// MARK: - Custom Functions

extension FlipItem {
  
  /// Flip Animation을 하기 전에 불리는 메소드입니다.
  /// label에 Flip할 이미지를 넣는 작업을 수행합니다.
  /// - Parameter newText: 변경될 텍스트
  private func updateWithText(_ newText: String) {
    let (previousTextTopView, previousTextBottomView) = createLabelImages()
    
    label.text = newText
    
    let nextTextBottomView = createLabelImages().bottom
    
    self.nextTextBottomView = nextTextBottomView
    self.previousTextTopView = previousTextTopView
    self.previousTextBottomView = previousTextBottomView
    
    [previousTextTopView, previousTextBottomView, nextTextBottomView].forEach {
      label.addSubview($0)
    }
    nextTextBottomView.isHidden = true // topView의 애니메이션 완료 후 보여질 예정
  }
  
  
  /// 현재 `label`을 위 아래 절반으로 자른 이미지로 반환합니다.
  /// - Returns: 윗 부분과 아랫부분의 레이블 이미지
  private func createLabelImages() -> (top: UIView, bottom: UIView) {
    
    // 현재 label의 이미지 값을 도출
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    // label 높이의 절반 크기로 설정
    let snapshotSize = CGSize(width: image.size.width, height: image.size.height * 0.5)
    
    
    // 윗부분을 이미지로 가져옴
    UIGraphicsBeginImageContextWithOptions(snapshotSize, false, 0)
    image.draw(at: .zero)
    let topSnapshotImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    // 아랫부분을 이미지로 가져옴
    UIGraphicsBeginImageContextWithOptions(snapshotSize, false, 0)
    image.draw(at: CGPoint(x: 0, y: -image.size.height * 0.5))
    let bottomSnapshotImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    let topView = UIImageView(image: topSnapshotImage)
    let bottomView = UIImageView(image: bottomSnapshotImage)
    
    // bottomimageView를 밑에 둚
    bottomView.frame.origin.y = snapshotSize.height
    
    return (topView, bottomView)
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
    if nextTextBottomView != nil {
      nextTextBottomView.layer.removeAllAnimations()
      nextTextBottomView.removeFromSuperview()
    }
    
    if previousTextTopView != nil {
      previousTextTopView.layer.removeAllAnimations()
      previousTextTopView.removeFromSuperview()
    }
    
    if previousTextBottomView != nil {
      previousTextBottomView.layer.removeAllAnimations()
      previousTextBottomView.removeFromSuperview()
    }
    
    label.layer.sublayers = nil
  }
}
