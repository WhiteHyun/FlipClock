//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

struct ThemeViewModel {
  
  let clockThemes: [UIImage?] = [.init(named: "theme1"), .init(named: "theme2")]
  let backgroundColor: [UIColor] = [.lightGray, .init(red: 0.941, green: 0.949, blue: 0.969, alpha: 1)]
  let textColor: [UIColor] = [.white, .black]
  let clockBackgroundColor: [UIColor] = [.black, .white]
  
  var numberOfRowsInSection: Int {
    clockThemes.count
  }
}
