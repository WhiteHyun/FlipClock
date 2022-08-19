//
//  FlipAnimationViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/18.
//

import Combine
import UIKit



class FlipAnimationViewModel {
  
  /// 윗부분이 0~90도로 Flip되는 시간(s) 설정
  var topAnimationDuration: CFTimeInterval = 0.4
  
  /// 아랫부분이 90~180도로 Flip되는 시간(s) 설정
  var bottomAnimationDuration: CFTimeInterval = 0.2
  
}
