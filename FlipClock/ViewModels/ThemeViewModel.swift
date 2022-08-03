//
//  ThemeViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

struct ThemeViewModel {
  
  let clockThemes: [UIImage?] = [.init(named: "theme1"), .init(named: "theme2")]
  
  var numberOfRowsInSection: Int {
    clockThemes.count
  }
}
