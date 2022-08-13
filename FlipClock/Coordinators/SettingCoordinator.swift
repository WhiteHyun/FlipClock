//
//  SettingCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

class SettingCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  weak var parentCoordinator: MainCoordinator?
  var navigationController: UINavigationController
  
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = SettingsViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
  func moveToThemeVC() {
    let child = ThemeCoordinator(navigationController: navigationController)
    child.start()
  }
}
