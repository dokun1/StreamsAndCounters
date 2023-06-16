//
//  OptionTwo.swift
//  StreamsAndActions
//
//  Created by David Okun on 6/15/23.
//

import SwiftUI
import Combine

final class CombineCounterModel: ObservableObject {
  var valueSubject = CurrentValueSubject<Int, Never>(0)
  var subscriptions = Set<AnyCancellable>()
  @Published var value = 0
  
  init() {
    valueSubject.sink { newValue in
      self.value = newValue
    }.store(in: &subscriptions)
  }
}

struct OptionTwoView: View {
  @StateObject var model: CombineCounterModel
  
  var body: some View {
    VStack {
      CombineCounterView(model: model)
        .padding()
      CombineLabelView(value: model.value)
    }.navigationTitle("Combine Counter")
  }
}

struct CombineCounterView: View {
  var model: CombineCounterModel
  
  var body: some View {
    HStack {
      Button {
        let newValue = model.valueSubject.value - 1
        model.valueSubject.send(newValue)
      } label: {
        Image(systemName: "minus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
      Button {
        let newValue = model.valueSubject.value + 1
        model.valueSubject.send(newValue)
      } label: {
        Image(systemName: "plus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
    }
  }
}

struct CombineLabelView: View {
  var value: Int
    
  var body: some View {
    Text("\(value)")
      .font(.title)
  }
}
