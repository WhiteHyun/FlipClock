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
  }
  
  private func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
}
