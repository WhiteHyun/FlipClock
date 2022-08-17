//
//  MainCoordinator.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit


class MainCoordinator: NSObject, Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    
    navigationController.delegate = self
    
    let vc = ViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: false)
    
    // 테마 설정 안되어 있다면 설정할 수 있도록 보여줌
    if !UserDefaults.standard.isThemeConfigured {
      let themeVC = ThemeViewController()
      themeVC.modalPresentationStyle = .fullScreen
      vc.present(themeVC, animated: true)
    }
  }
  
  
  func moveToSetting() {
    let child = SettingCoordinator(navigationController: navigationController)
    
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }
  
  
  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child {
        childCoordinators.remove(at: index)
        break
      }
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
