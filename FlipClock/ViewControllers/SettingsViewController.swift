//
//  SettingsViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import UIKit

import SnapKit
import Then

class SettingsViewController: UITableViewController {

  weak var coordinator: SettingCoordinator?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTableView()
  }
}

// MARK: - Configuration

extension SettingsViewController {

  private func configureUI() {
    view.backgroundColor = .lightGray

    let label = UILabel().then {
      $0.textAlignment = .center
      $0.text = "준비중이에요!"
      $0.textColor = .darkGray
      $0.font = .systemFont(ofSize: 30, weight: .semibold)
    }
    view.addSubview(label)

    label.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }

  private func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
}
