//
//  ThemeViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/02.
//

import UIKit

class ThemeViewController: UITableViewController {
  
  weak var coordinator: ThemeCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTableView()
  }
  
  private func configureUI() {
    view.backgroundColor = .white
  }
  
  private func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
}
