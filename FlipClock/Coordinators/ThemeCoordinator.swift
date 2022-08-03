//
//  ThemeCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

class ThemeCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  
  func start() {
    let vc = ThemeViewController()
    vc.coordinator = self
    navigationController.viewControllers.last?.present(vc, animated: true)
  }
}
