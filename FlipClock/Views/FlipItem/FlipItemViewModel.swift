//
//  FlipItemViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/18.
//

import Combine
import UIKit


class FlipitemViewModel {
  
  /// Flippable label Text
  @Published var text: String?
  
  /// Flip할 이미지를 만듭니다.
  ///
  /// 파라미터로 들어온 **newText**로 인해서 두 번쨰 파라미터인 label의 값이 새로이 갱신됩니다.
  ///
  /// - Parameter view: label을 감싸고 있는 view
  /// - Parameter label: 숫자가 들어간 label
  /// - Parameter newText: 변경될 텍스트
  /// - Returns: 변경 전 플립시계 이미지 윗부분과 아랫부분, 변경된 플립시계 이미지 아랫부분
  func createSnapshots(_ view: UIView, label: UILabel, newText: String) -> (prevTop: UIView, prevBottom: UIView, nextBottom: UIView) {
    let (previousTextTopView, previousTextBottomView) = createLabelImages(view)
    
    label.text = newText
    
    let nextTextBottomView = createLabelImages(view).bottom
    
    nextTextBottomView.isHidden = true // topView의 애니메이션 완료 후 보여질 예정
    
    return (previousTextTopView, previousTextBottomView, nextTextBottomView)
  }
  
  
  /// `view`를 위 아래 절반으로 자른 이미지로 반환합니다.
  /// - Returns: 윗 부분과 아랫부분의 레이블 이미지
  private func createLabelImages(_ view: UIView) -> (top: UIView, bottom: UIView) {
    
    // 현재 label의 이미지 값을 도출
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
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

