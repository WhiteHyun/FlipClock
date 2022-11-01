//
//  AppCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/11/02.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

  override func start() {
    self.navigationController.delegate = self
    let coordinator = HomeCoordinator(navigationController: self.navigationController)
    self.start(child: coordinator)
  }
}

// MARK: - UINavigationControllerDelegate

extension AppCoordinator: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) as? BaseViewController,
          let coordinator = fromVC.coordinator
    else { return }

    if navigationController.viewControllers.contains(fromVC) { return }

    // Coordinators must have their own parents except for the `AppCoordinator`.
    assert(coordinator.parentCoordinator != nil)

    coordinator.parentCoordinator?.remove(child: coordinator)
  }
}
