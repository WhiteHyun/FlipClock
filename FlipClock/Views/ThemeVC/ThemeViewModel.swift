//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

import RxSwift

struct ThemeViewModel {

  private let clockThemes = [UIImage(named: "theme1"), UIImage(named: "theme2")]

  var data: Observable<[UIImage?]> {
    return Observable.just(clockThemes)
  }

  func store(with index: Int) {
    UserDefaults.standard.theme = index
  }
}
