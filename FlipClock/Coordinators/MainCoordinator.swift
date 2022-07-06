//
//  MainCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import Foundation
import UIKit


class MainCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = ViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
    
  }
  
  
}
