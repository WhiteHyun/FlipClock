//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

struct ThemeViewModel {

  let clockThemes: [UIImage?] = [.init(named: "theme1"), .init(named: "theme2")]
  private let backgroundColorTheme = [0xAAAAAA, 0xF0F2F7]
  private let textColorTheme = [0xFFFFFF, 0x000000]
  private let clockBackgroundColorTheme = [0x000000, 0xFFFFFF]

  var numberOfRowsInSection: Int {
    clockThemes.count
  }

  func userDefaults(storeWith index: Int) {
    UserDefaults.standard.do {
      $0.backgroundColorTheme = backgroundColorTheme[index]
      $0.textColorTheme = textColorTheme[index]
      $0.clockBackgroundColorTheme = clockBackgroundColorTheme[index]
    }
  }
}
