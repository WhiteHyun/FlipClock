//
//  SettingsCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {
  override func start() {
    let settingVC = SettingsViewController()
    settingVC.coordinator = self
    navigationController.pushViewController(settingVC, animated: true)
  }

  func moveToThemeVC() {
    let coordinator = ThemeCoordinator(navigationController: navigationController)
    self.start(child: coordinator)
  }
}
