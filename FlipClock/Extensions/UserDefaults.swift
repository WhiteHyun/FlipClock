import Foundation

extension UserDefaults {
  
  var backgroundColorTheme: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
  var textColor: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
  var clockBackgroundColor: Int {
    get { integer(forKey: #function) }
    set { set(newValue, forKey: #function) }
  }
  
}
