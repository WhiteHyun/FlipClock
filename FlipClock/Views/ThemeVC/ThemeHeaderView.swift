//
//  ThemeHeaderView.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/10/12.
//

import UIKit

final class ThemeHeaderView: UITableViewHeaderFooterView {

  static let id = "ThemeHeaderView"

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupStyles()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupStyles() {
    var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
    backgroundConfig.backgroundColor = .systemGray
    backgroundConfiguration = backgroundConfig
  }
}
