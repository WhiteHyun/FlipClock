//
//  FlipItem.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import SnapKit
import Then


class FlipItem: UIView {
  
  // MARK: - Properties
  
  private let label = UILabel().then {
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 90, weight: .bold)
    $0.text = "00"
    $0.textColor = .systemGray5
  }
  
  /// Flippable label Text
  var text: String? {
    get {
      return label.text
    }
    
    set {
      guard let value = newValue, label.text != newValue else { return }
      updateWithText(value)
      animationStart()
    }
  }
  
  private lazy var backgroundGradientLayer = CAGradientLayer().then {
    $0.frame = bounds
    $0.colors = [
      UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1).cgColor,
      UIColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 1).cgColor
    ]
  }
  
  // Flip되는 시간 설정
  private let topAnimationDuration: CFTimeInterval = 0.4
  private let bottomAnimationDuration: CFTimeInterval = 0.2
  
  
  private var previousTextTopView: UIView!
  private var previousTextBottomView: UIView!
  
  private var nextTextBottomView: UIView!
  
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Layout Cycle

extension FlipItem {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setGradientBackgroundColor()
    label.clipsToBounds = false // stackview 회전할 때 true값이 됨 (이유 모름)
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
    
    let (_, nextTextBottomView) = createLabelImages()
    
    self.nextTextBottomView = nextTextBottomView
    self.previousTextTopView = previousTextTopView
    self.previousTextBottomView = previousTextBottomView
    
    [previousTextTopView, previousTextBottomView].forEach {
      label.addSubview($0)
    }
  }
  
  private func setGradientBackgroundColor() {
    
    UIGraphicsBeginImageContext(bounds.size)
    //create UIImage by rendering gradient layer.
    backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    //get gradient UIcolor from gradient UIImage
    backgroundColor = UIColor(patternImage: image!)
    
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
  private func animationStart() {
    shadowAnimation()
    topLabelFlippingAnimation()
    bottomShadowAnimation()
  }
  
  /// 윗 부분과 아랫부분 글자의 그림자 애니메이션을 추가합니다.
  private func shadowAnimation() {
    let topViewShadow = UIView(frame: previousTextTopView.bounds)
    topViewShadow.backgroundColor = .black
    topViewShadow.alpha = 0
    topViewShadow.layer.cornerRadius = 15
    
    previousTextTopView.addSubview(topViewShadow)
    
    let bottomViewShadow = UIView(frame: previousTextBottomView.bounds)
    bottomViewShadow.backgroundColor = .black
    bottomViewShadow.alpha = 0
    bottomViewShadow.layer.cornerRadius = 15
    
    previousTextBottomView.addSubview(bottomViewShadow)
    
    UIView.animate(withDuration: topAnimationDuration) {
      topViewShadow.alpha = 0.3
    }
    
    UIView.animate(withDuration: topAnimationDuration) {
      bottomViewShadow.alpha = 0.2
    }
  }
  
  private func topLabelFlippingAnimation() {
    
    
    // 기준점 가운데 하단으로 설정
    previousTextTopView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    
    // 기준점 변경으로 인한 center값 조정 (layer Position)
    previousTextTopView.center = CGPoint(
      x: previousTextTopView.frame.width * 0.5,
      y: previousTextTopView.frame.height
    )
    
    
    let topAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
    topAnimation.duration = topAnimationDuration // 애니메이션 시간
    topAnimation.fromValue = 0 // 0부터
    topAnimation.toValue = Double.pi * 0.5 // 90도 까지
    topAnimation.delegate = self
    
    topAnimation.fillMode = .forwards // 애니메이션 끝난 뒤 변경상태 유지
    topAnimation.timingFunction = .init(name: .easeIn)
    
    topAnimation.setValue("End", forKey: "topAnimation") // key값 설정
    
    
    
    // 3D 변환행렬 이용하여 label 회전
    var perspectiveTransform = CATransform3DIdentity
    perspectiveTransform.m34 = 0.0025
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, .pi * 0.5, 1, 0, 0)
    previousTextTopView.layer.transform = perspectiveTransform
    
    
    previousTextTopView.layer.add(topAnimation, forKey: "topRotation") // 애니메이션 시작
  }
  
  private func bottomShadowAnimation() {
    
    let bottomShadowLayer: CAShapeLayer = CAShapeLayer()
    
    let frame = CGRect(
      x: 0,
      y: 0,
      width: previousTextBottomView.frame.width,
      height: previousTextBottomView.frame.height * 0.8
    )
    
    previousTextBottomView.layer.addSublayer(bottomShadowLayer)
    
    
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: frame.width, y: 0.0))
    path.addLine(to: CGPoint(x: frame.width, y: 0.0))
    path.close()
    
    
    bottomShadowLayer.path = path.cgPath
    bottomShadowLayer.opacity = 0.3
    bottomShadowLayer.fillColor = UIColor.black.cgColor
    bottomShadowLayer.frame = frame
    
    
    let endPath = UIBezierPath()
    endPath.move(to: .zero)
    endPath.addLine(to: CGPoint(x: frame.width, y: 0.0))
    endPath.addLine(to: CGPoint(x: frame.width, y: frame.height))
    endPath.addLine(to: CGPoint(x: 0.0, y: frame.height))
    endPath.close()
    
    
    let animation = CAKeyframeAnimation(keyPath: "path")
    animation.values = [
      path.cgPath,
      endPath.cgPath
    ]
    
    animation.timingFunctions = [
      CAMediaTimingFunction(name: .easeIn),
      CAMediaTimingFunction(name: .linear)
    ]
    animation.duration = topAnimationDuration + bottomAnimationDuration - 0.2
    
    
    bottomShadowLayer.add(animation, forKey: "shadowAnimation")
  }
  
  private func bottomLabelFlippingAnimation() {
    
    label.addSubview(nextTextBottomView)
    
    
    nextTextBottomView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
    nextTextBottomView.center = CGPoint(
      x: nextTextBottomView.frame.width * 0.5,
      y: nextTextBottomView.frame.height
    )
    
    
    let bottomAnimation = CABasicAnimation(keyPath:"transform.rotation.x")
    bottomAnimation.duration = bottomAnimationDuration
    bottomAnimation.fromValue = Double.pi * 0.5
    bottomAnimation.toValue = 0
    bottomAnimation.delegate = self
    
    bottomAnimation.fillMode = .forwards
    bottomAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
    
    bottomAnimation.setValue("End", forKey: "bottomAnimation")
    
    
    var perspectiveTransform = CATransform3DIdentity
    perspectiveTransform.m34 = -1 / 340
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, .pi * 0.5, 1, 0, 0)
    nextTextBottomView.layer.transform = perspectiveTransform
    
    
    nextTextBottomView.layer.add(bottomAnimation, forKey: "bottomRotation")
  }
  
  
  /// 모든 애니메이션을 중지시키고, 애니메이션 이미지를 삭제합니다.
  func stopAnimations() {
    if nextTextBottomView != nil {
      nextTextBottomView.layer.removeAllAnimations()
      nextTextBottomView.removeFromSuperview()
      nextTextBottomView = nil
    }
    
    if previousTextTopView != nil {
      previousTextTopView.layer.removeAllAnimations()
      previousTextTopView.removeFromSuperview()
      previousTextTopView = nil
    }
    
    if previousTextBottomView != nil {
      previousTextBottomView.layer.removeAllAnimations()
      previousTextBottomView.removeFromSuperview()
      previousTextBottomView = nil
    }
  }
}


extension FlipItem: CAAnimationDelegate {
  
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if flag {
      if anim.value(forKey: "topAnimation") != nil {
        bottomLabelFlippingAnimation()
      }
      else if anim.value(forKey: "bottomAnimation") != nil {
        stopAnimations()
      }
    }
  }
}
