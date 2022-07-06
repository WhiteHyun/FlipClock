//
//  ViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
  
  
  private lazy var label = FlippableLabel()
  
  var timer: Timer?
  
  let formatter = DateFormatter().then {
    $0.dateFormat = "ss"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 1)
    view.backgroundColor = .white
    
    view.addSubview(label)
    
    label.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
      make.height.width.equalTo(200)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(test), userInfo: nil, repeats: true)
    }
  }
  
 
  @objc func test() {
    label.text = formatter.string(from: .now)
  }
  
  
}
