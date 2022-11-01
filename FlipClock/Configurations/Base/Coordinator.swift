//
//  Coordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

protocol Coordinator: AnyObject {

  var childCoordinators: [Coordinator] { get set }
  var parentCoordinator: Coordinator? { get set }
  var navigationController: UINavigationController { get set }

  func start()
  func start(child: Coordinator)
  func remove(child: Coordinator)
}


extension Coordinator {
  
  func start(child: Coordinator) {
    self.childCoordinators.append(child)
    child.parentCoordinator = self
    child.start()
  }
  
  func remove(child: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== child }
  }
}
