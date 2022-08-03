import Foundation

extension UserDefaults {
  
  var backgroundColorTheme: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
  var textColorTheme: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
  var clockBackgroundColorTheme: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
}
