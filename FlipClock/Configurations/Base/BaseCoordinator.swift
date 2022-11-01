//
//  BaseCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/11/01.
//

import UIKit

class BaseCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var parentCoordinator: Coordinator?
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    fatalError("start() must be implemented")
  }
}
