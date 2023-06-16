//
//  OptionFour.swift
//  StreamsAndActions
//
//  Created by David Okun on 6/15/23.
//

import SwiftUI
import AsyncAlgorithms

final class ChannelCounterModel {
  public var channel = AsyncChannel<Int>()
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
    await channel.send(value)
  }
}

struct OptionFourView: View {
  var model: ChannelCounterModel
  
  var body: some View {
    VStack {
      ChannelCounterView(model: model)
        .padding()
      ChannelLabelView(channel: model.channel)
    }.navigationTitle("AsyncChannel Counter")
  }
}

struct ChannelCounterView: View {
  var model: ChannelCounterModel
  
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

struct ChannelLabelView: View {
  @State var value = 0
  var channel: AsyncChannel<Int>
    
  var body: some View {
    Text("\(value)")
      .font(.title)
      .task {
        for await updatedValue in channel {
          self.value = updatedValue
        }
      }
  }
}
