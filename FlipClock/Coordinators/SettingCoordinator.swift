//
//  SettingCoordinator.swift
//  FlipClock
//
//  Created by νμΉν on 2022/07/06.
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
}
