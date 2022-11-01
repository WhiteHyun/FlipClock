//
//  SceneDelegate.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import RxSwift
import RxCocoa

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private let disposeBag: DisposeBag = DisposeBag()
  private let coordinator: AppCoordinator = AppCoordinator(
    navigationController: UINavigationController()
  )
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = coordinator.navigationController
    window?.makeKeyAndVisible()

    coordinator.start()

    // MARK: UserDefaults Observation

    UserDefaults.standard.rx
      .observeWeakly(Int.self, "theme")
      .compactMap { $0 }
      .map { Theme(rawValue: $0) }
      .compactMap { $0 }
      .subscribe(onNext: {
        Theme.currentTheme.accept($0)
      })
      .disposed(by: disposeBag)

  }
}
