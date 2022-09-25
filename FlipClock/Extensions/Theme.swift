//
//  Theme.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/09/23.
//

import Foundation

import RxCocoa

enum Theme: Int {
  case dark
  case light
  
  static let currentTheme = BehaviorRelay<Int>(value: UserDefaults.standard.theme)

  var colors: HexColor {
    switch self {
    case .dark:
      return HexColor(background: 0xAAAAAA, text: 0xFFFFFF, clockBackground: 0x000000)
    case .light:
      return HexColor(background: 0xF0F2F7, text: 0x000000, clockBackground: 0xFFFFFF)
    }
  }
}

// MARK: - Color(Hex Value)

extension Theme {
  struct HexColor {
    let background: Int
    let text: Int
    let clockBackground: Int
  }
}
