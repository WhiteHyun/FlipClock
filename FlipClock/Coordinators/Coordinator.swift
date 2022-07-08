//
//  Coordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit



protocol Coordinator: AnyObject {
  
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
  
}
