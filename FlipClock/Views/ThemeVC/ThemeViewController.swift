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

  weak var coordinator: ThemeCoordinator?
  private let viewModel = ThemeViewModel()
  private let disposeBag = DisposeBag()

  private lazy var tableView = UITableView().then {
    $0.separatorStyle = .none
    $0.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.id)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    binding()
  }

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
      )) { _, element, cell in
        guard let element = element else { return }
        cell.configure(with: element)
      }
      .disposed(by: disposeBag)

    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] in
        self?.viewModel.store(with: $0.row)
        self?.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
  }
}
