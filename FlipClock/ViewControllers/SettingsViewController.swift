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
  var viewModel = SettingsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTableView()
  }
}

// MARK: - Configuration

extension SettingsViewController {
  
  private func configureUI() {
    view.backgroundColor = .white
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
    return viewModel.numberOfSections
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else {
      fatalError("Cell을 다운캐스팅할 수 없습니다.")
    }
    var content = cell.defaultContentConfiguration()
    content.image = UIImage(systemName: viewModel.cellImageNames[indexPath.section])
    content.text = viewModel.cellTitles[indexPath.section]
    content.imageProperties.tintColor = .black
    cell.contentConfiguration = content
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.sections[section]
  }
}

// MARK: - UITableViewDelegate

extension SettingsViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.section {
    case 0: // theme
      break
    case 1: // mail
      break
    case 2: // share
      break
    default:
      break
    }
  }
}
