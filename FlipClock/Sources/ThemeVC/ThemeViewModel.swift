//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

import RxSwift

struct ThemeViewModel {

  let clockThemes = [
    "흑",
    "백"
  ]

  func store(with index: Int) {
    UserDefaults.standard.theme = index
  }
}
