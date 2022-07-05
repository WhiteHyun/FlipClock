//
//  ViewController.swift
//  FlipClock
//
//  Created by 홍승현 on 2022/06/25.
//

import UIKit

class ViewController: UIViewController {
  
//  private lazy var label = FlippableLabel(frame: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200))
  private lazy var label = FlippableLabel(frame: view.bounds)
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 1)
    view.backgroundColor = .white
    
    view.addSubview(label)
    
    
    
    
    label.text = "01"
  }
  
  
}

