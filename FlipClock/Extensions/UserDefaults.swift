import Foundation

extension UserDefaults {
  @objc var theme: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
}
