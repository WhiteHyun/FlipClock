//
//  ThemeViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/02.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class ThemeViewController: UIViewController {

  var coordinator: ThemeCoordinator?
  private let viewModel = ThemeViewModel()

  private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.register(ThemeHeaderView.self, forHeaderFooterViewReuseIdentifier: ThemeHeaderView.id)
    $0.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.id)
    $0.dataSource = self
    $0.delegate = self
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  // MARK: - Configuration

  private func configureUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)

    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

// MARK: - UITableViewDataSource

extension ThemeViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.clockThemes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ThemeTableViewCell.id,
      for: indexPath
    ) as? ThemeTableViewCell else {
      fatalError()
    }

    cell.accessoryType = UserDefaults.standard.theme == indexPath.row ? .checkmark : .none
    cell.configure(with: viewModel.clockThemes[indexPath.row])
    return cell
  }

}

// MARK: - UITableViewDelegate

extension ThemeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.store(with: indexPath.row)
    tableView.reloadData()
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: ThemeHeaderView.id
    ) as? ThemeHeaderView else {
      return nil
    }

    return headerView
  }
}
