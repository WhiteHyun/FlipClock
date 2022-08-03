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
  
  var isThemeConfigured: Bool {
    backgroundColorTheme != 0 || textColorTheme != 0 || clockBackgroundColorTheme != 0
  }
}
