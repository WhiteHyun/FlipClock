//
//  ThemeTableViewCell.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/03.
//

import UIKit

import SnapKit
import Then

final class ThemeTableViewCell: UITableViewCell {

  static let id = "ThemeTableViewCell"

  private lazy var themeLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    contentView.addSubview(themeLabel)

    themeLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
  }

  func configure(with text: String) {
    themeLabel.text = text
  }
}
