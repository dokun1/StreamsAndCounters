//
//  ContentView.swift
//  StreamsAndActions
//
//  Created by David Okun on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationStack {
        List {
          NavigationLink(value: 1) {
            Text("Simple Counter")
          }
          NavigationLink(value: 2) {
            Text("Combine Counter")
          }
          NavigationLink(value: 3) {
            Text("AsyncStream Counter")
          }
          NavigationLink(value: 4) {
            Text("Channel Counter")
          }
        }.navigationDestination(for: Int.self) { value in
          switch value {
            case 1: OptionOneView(model: .init())
            case 2: OptionTwoView(model: .init())
            case 3: OptionThreeView(model: .init())
            case 4: OptionFourView(model: .init())
            default: EmptyView()
          }
        }.navigationTitle("Changing Values")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
