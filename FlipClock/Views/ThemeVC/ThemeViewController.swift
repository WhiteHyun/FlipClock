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
  private let disposeBag = DisposeBag()

  private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.id)
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    binding()
  }

  // MARK: - Configuration

  private func configureUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)

    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func binding() {
    viewModel.data
      .bind(to: tableView.rx.items(
        cellIdentifier: ThemeTableViewCell.id,
        cellType: ThemeTableViewCell.self
      )) { index, element, cell in
        cell.accessoryType = UserDefaults.standard.theme == index ? .checkmark : .none
        cell.configure(with: element)
      }
      .disposed(by: disposeBag)

    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] in
        self?.viewModel.store(with: $0.row)
        self?.tableView.reloadData()
      })
      .disposed(by: disposeBag)
  }
}
