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
  
  private lazy var themeImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    contentView.addSubview(themeImageView)
    
    themeImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    
    contentView.backgroundColor = .white
  }
  
  func configure(with image: UIImage) {
    themeImageView.image = image
  }
}
