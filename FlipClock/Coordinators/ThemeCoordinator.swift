//
//  ThemeCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

final class ThemeCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let themeVC = ThemeViewController()
    themeVC.coordinator = self
    navigationController.viewControllers.last?.present(themeVC, animated: true)
  }
}
