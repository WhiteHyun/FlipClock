//
//  ContentView.swift
//  Flip Clock
//
//  Created by 홍승현 on 2023/06/13.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
    }
    .padding()
  }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
