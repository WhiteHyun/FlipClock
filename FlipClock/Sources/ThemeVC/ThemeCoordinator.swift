//
//  ThemeCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

final class ThemeCoordinator: BaseCoordinator {
  override func start() {
    let themeVC = ThemeViewController()
    themeVC.coordinator = self
    navigationController.pushViewController(themeVC, animated: true)
  }
}
