//
//  OptionThree.swift
//  StreamsAndActions
//
//  Created by David Okun on 6/15/23.
//

import SwiftUI

final class AsyncCounterModel {
  public lazy var stream: AsyncStream<Int> = {
    AsyncStream { (continuation: AsyncStream<Int>.Continuation) -> Void in
      self.continuation = continuation
    }
  }()
  
  private var continuation: AsyncStream<Int>.Continuation?
  private var value = 0
  
  public func incrementValue() async {
    value += 1
    await hydrate()
  }
  
  public func decrementValue() async {
    value -= 1
    await hydrate()
  }
  
  public func hydrate() async {
    continuation?.yield(value)
  }
}

struct OptionThreeView: View {
  var model: AsyncCounterModel
  
  var body: some View {
    VStack {
      AsyncCounterView(model: model)
        .padding()
      AsyncLabelView(stream: model.stream)
    }.navigationTitle("AsyncStream Counter")
  }
}

struct AsyncCounterView: View {
  var model: AsyncCounterModel
  
  var body: some View {
    HStack {
      Button {
        Task { await model.decrementValue() }
      } label: {
        Image(systemName: "minus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
      Button {
        Task { await model.incrementValue() }
      } label: {
        Image(systemName: "plus.square")
          .resizable()
          .frame(width: 80, height: 80)
      }.padding()
    }.task {
      await model.hydrate()
    }
  }
}

struct AsyncLabelView: View {
  @State var value = 0
  var stream: AsyncStream<Int>
    
  var body: some View {
    Text("\(value)")
      .font(.title)
      .task { 
        for await updatedValue in stream {
          self.value = updatedValue
        }
      }
  }
}
