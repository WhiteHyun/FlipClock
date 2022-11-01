//
//  SettingCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

final class SettingCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []
  weak var parentCoordinator: HomeCoordinator?
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let settingVC = SettingsViewController()
    settingVC.coordinator = self
    navigationController.pushViewController(settingVC, animated: true)
  }

  func moveToThemeVC() {
    let child = ThemeCoordinator(navigationController: navigationController)
    child.start()
  }
}
