//
//  SettingsViewModel.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/02.
//

import Foundation

struct SettingsViewModel {

  let sections = ["배경 테마", "피드백"]

  let cellTitles = ["테마 변경", "의견 보내기"]
  let cellImageNames = ["paintbrush", "ellipsis.bubble"]

  var numberOfSections: Int {
    sections.count
  }

  let numberOfRowsInSection = 1
}