//
//  FlipAnimationViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/18.
//

import Combine
import UIKit


struct FlipAnimationViewModel {
  
  func shadowAnimation(_ view: UIView, alpha: CGFloat) {
    let shadow = UIView(frame: view.bounds).then {
      $0.backgroundColor = .black
      $0.alpha = 0
      $0.layer.cornerRadius = 15
    }
    
    view.addSubview(shadow)
    
    UIView.animate(withDuration: FlipType.top.duration) {
      shadow.alpha = alpha
    }
  }
  
  /// Flip 애니메이션을 진행합니다.
  /// - Parameters:
  ///   - view: 애니메이션을 적용할 view
  ///   - type: flip되는 부분
  ///   - completion: `animation`이 끝난 뒤에 실행되는 클로저
  func flipAnimation(_ view: UIView, type: FlipType, completion: (() -> Void)? = nil) {
    
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    // 기준점 설정
    view.layer.anchorPoint = type.anchorPoint
    
    // 기준점 변경으로 인한 center값 조정 (layer에서의 position)
    view.center = CGPoint(
      x: view.bounds.width * 0.5,
      y: view.bounds.height
    )
    
    let animation = CABasicAnimation(keyPath: "transform.rotation.x")
    animation.duration = type.duration // 애니메이션 시간
    
    animation.fromValue = type.startDegree
    animation.toValue = type.destinationDegree
    
    animation.fillMode = .forwards // 애니메이션 끝난 뒤 변경상태 유지
    animation.isRemovedOnCompletion = false // 애니메이션 끝난 뒤 깜빡이는 현상 수정
    animation.timingFunction = type.animationTimingFunction
    
    animation.setValue("End", forKey: type.id) // key값 설정
    
    view.layer.transform = type.perspectiveTransform
    
    
    view.layer.add(animation, forKey: "rotation") // 애니메이션 시작
    
    CATransaction.commit()
  }
  
  /// 위 Flip 이미지로 인한 그림자를 생성해주기 위한 애니메이션입니다.
  func bottomShadowAnimation(_ view: UIView) {
    
    let bottomShadowLayer = CAShapeLayer()
    
    let frame = CGRect(
      x: 0,
      y: 0,
      width: view.frame.width,
      height: view.frame.height
    )
    
    view.layer.addSublayer(bottomShadowLayer)
    
    
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: frame.width, y: 0.0))
    path.addLine(to: CGPoint(x: frame.width, y: 0.0))
    path.close()
    
    
    bottomShadowLayer.opacity = 0.3
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
      .init(name: .easeIn),
      .init(name: .linear)
    ]
    animation.duration = FlipType.top.duration + FlipType.bottom.duration
    
    
    bottomShadowLayer.add(animation, forKey: "shadowAnimation")
  }
}

// MARK: - FlipType

extension FlipAnimationViewModel {
  enum FlipType {
    case top
    case bottom
    
    var id: String {
      switch self {
      case .top:
        return "topAnimation"
      case .bottom:
        return "bottomAnimation"
      }
    }
    
    var anchorPoint: CGPoint {
      switch self {
      case .top:
        return .init(x: 0.5, y: 1)
      case .bottom:
        return .init(x: 0.5, y: 0)
      }
    }
    
    var startDegree: Double {
      switch self {
      case .top:
        return 0
      case .bottom:
        return .pi * 0.5
      }
    }
    
    var destinationDegree: Double {
      switch self {
      case .top:
        return .pi * 0.5
      case .bottom:
        return 0
      }
    }
    
    /// label 회전을 이용하므로 3D 변환행렬 이용
    var perspectiveTransform: CATransform3D {
      var transform = CATransform3DIdentity
      transform.m34 = self == .top ? 0.0025 : -0.0029
      return CATransform3DRotate(transform, .pi * 0.5, 1, 0, 0)
    }
    
    /// Flip되는 시간(s)
    var duration: CFTimeInterval {
      switch self {
      case .top:
        return 0.4
      case .bottom:
        return 0.2
      }
    }
    
    var animationTimingFunction: CAMediaTimingFunction {
      switch self {
      case .top:
        return .init(name: .easeIn)
      case .bottom:
        return .init(name: .linear)
      }
    }
  }
}
