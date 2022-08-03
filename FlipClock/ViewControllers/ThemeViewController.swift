//
//  ThemeViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/02.
//

import UIKit

class ThemeViewController: UITableViewController {
  
  weak var coordinator: ThemeCoordinator?
  let viewModel = ThemeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTableView()
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
  }
  
  private func configureTableView() {
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ThemeTableViewCell.self, forCellReuseIdentifier: ThemeTableViewCell.id)
  }
}


// MARK: - UITableViewDataSource

extension ThemeViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ThemeTableViewCell.id, for: indexPath) as? ThemeTableViewCell,
          let image = viewModel.clockThemes[indexPath.row]
    else {
      fatalError("Error!")
    }
    
    cell.configure(with: image)
    
    return cell
  }
}


extension ThemeViewController {
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 230
  }
}
