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
      red: rgb & 0xFF0000,
      green: rgb & 0xFF00,
      blue: rgb & 0xFF
    )
  }
}
