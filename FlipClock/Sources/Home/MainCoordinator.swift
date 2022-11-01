//
//  MainCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {

  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {

    navigationController.delegate = self

    let homeVC = ViewController()
    homeVC.coordinator = self
    navigationController.pushViewController(homeVC, animated: false)
  }

  func moveToSetting() {
    let child = SettingCoordinator(navigationController: navigationController)

    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }

  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
      childCoordinators.remove(at: index)
      break
    }
  }
}

// MARK: - UINavigationControllerDelegate

extension MainCoordinator: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
      return
    }

    if navigationController.viewControllers.contains(fromVC) {
      return
    }

    if let settingVC = fromVC as? SettingsViewController {
      childDidFinish(settingVC.coordinator)
    }
  }
}
