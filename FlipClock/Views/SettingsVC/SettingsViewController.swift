//
//  SettingsViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/07/06.
//

import MessageUI
import UIKit

import SnapKit
import Then

final class SettingsViewController: UIViewController {

  weak var coordinator: SettingCoordinator?
  var viewModel = SettingsViewModel()

  private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.dataSource = self
    $0.delegate = self
    $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayout()
    configureConstraints()
    configureUI()
  }
}

// MARK: - Configuration

extension SettingsViewController {

  private func configureLayout() {
    view.addSubview(tableView)
  }

  private func configureConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func configureUI() {
    view.backgroundColor = .systemBackground
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: SettingTableViewCell.id,
      for: indexPath
    ) as? SettingTableViewCell else {
      fatalError("Cell을 다운캐스팅할 수 없습니다.")
    }
    var content = cell.defaultContentConfiguration()
    content.image = UIImage(systemName: viewModel.cellImageNames[indexPath.section])
    content.text = viewModel.cellTitles[indexPath.section]
    content.imageProperties.tintColor = .black
    cell.contentConfiguration = content

    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.sections[section]
  }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    switch indexPath.section {
    case 0: // theme
      coordinator?.moveToThemeVC()
    case 1: // mail
      sendMail()
    default:
      break
    }
  }
}

// MARK: - MFMailComposeViewController

extension SettingsViewController: MFMailComposeViewControllerDelegate {

  private func showMailErrorAlert() {
    let controller = UIAlertController(title: "실패", message: "아이폰 메일 설정을 확인해주세요.", preferredStyle: .alert)
    controller.addAction(UIAlertAction(title: "확인", style: .default))
    present(controller, animated: true)
  }

  private func sendMail() {
    guard MFMailComposeViewController.canSendMail() else {
      showMailErrorAlert()
      return
    }
    let composeVC = MFMailComposeViewController()
    composeVC.mailComposeDelegate = self
    composeVC.setToRecipients(["whi7ehyun@gmail.com"])
    composeVC.setSubject("<Flip Clock> 문의 및 의견")
    present(composeVC, animated: true)
  }

  func mailComposeController(
    _ controller: MFMailComposeViewController,
    didFinishWith result: MFMailComposeResult,
    error: Error?
  ) {
    controller.dismiss(animated: true)
  }
}
