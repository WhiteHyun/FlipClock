//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

import RxSwift
import Then

struct ThemeViewModel {

  private let clockThemes = [UIImage(named: "theme1"), UIImage(named: "theme2")]
  private let backgroundColorTheme = [0xAAAAAA, 0xF0F2F7]
  private let textColorTheme = [0xFFFFFF, 0x000000]
  private let clockBackgroundColorTheme = [0x000000, 0xFFFFFF]

  var data: Observable<[UIImage?]> {
    return Observable.just(clockThemes)
  }

  func userDefaults(storeWith index: Int) {
    UserDefaults.standard.do {
      $0.backgroundColorTheme = backgroundColorTheme[index]
      $0.textColorTheme = textColorTheme[index]
      $0.clockBackgroundColorTheme = clockBackgroundColorTheme[index]
    }
  }
}
