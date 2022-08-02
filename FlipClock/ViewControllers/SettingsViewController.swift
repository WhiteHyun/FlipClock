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
    tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else {
      fatalError("Cell을 다운캐스팅할 수 없습니다.")
    }
    var content = cell.defaultContentConfiguration()
    content.image = UIImage(systemName: "star")
    content.text = "Hello, World!"
    
    cell.contentConfiguration = content
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ["배경 테마", "피드백", "공유"][section]
  }
}
