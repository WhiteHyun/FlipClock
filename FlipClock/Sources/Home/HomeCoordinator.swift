//
//  HomeCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {

  override func start() {
    let homeVC = HomeViewController()
    homeVC.coordinator = self
    navigationController.pushViewController(homeVC, animated: false)
  }

  func moveToSetting() {
    let coordinator = SettingsCoordinator(navigationController: navigationController)
    start(child: coordinator)
  }
}
