//
//  SettingTableViewCell.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/08/02.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
  
  static let id = "SettingTableViewCell"
  
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configure() {
    accessoryType = .disclosureIndicator
  }
}
