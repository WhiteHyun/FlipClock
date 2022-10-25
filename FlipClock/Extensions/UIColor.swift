import UIKit

extension UIColor {

  convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
    self.init(
      red: CGFloat(red) / 255,
      green: CGFloat(green) / 255,
      blue: CGFloat(blue) / 255,
      alpha: CGFloat(alpha) / 255
    )
  }

  convenience init(rgb: Int) {
    self.init(
      red: rgb >> 16 & 0xFF,
      green: rgb >> 8 & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
