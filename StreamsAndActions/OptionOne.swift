//
//  OptionOne.swift
//  StreamsAndActions
//
//  Created by David Okun on 6/15/23.
//

import SwiftUI

final class SimpleCounterModel: ObservableObject {
  @Published var counter: Int = 0
}

struct OptionOneView: View {
  @StateObject var model: SimpleCounterModel
  
  var body: some View {
    VStack {
      SimpleCounterView(model: model)
        .padding()
      SimpleLabelView(model: model)
    }.navigationTitle("Simple Counter")
  }
}

struct SimpleCounterView: View {
  @StateObject var model: SimpleCounterModel
  
  var body: some View {
    HStack {
      Button {
        model.counter -= 1
      } label: {
        Image(systemName: "minus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
      Button {
        model.counter += 1
      } label: {
        Image(systemName: "plus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
    }
  }
}

struct SimpleLabelView: View {
  @StateObject var model: SimpleCounterModel
  
  var body: some View {
    Text("\(model.counter)")
      .font(.title)
  }
}
