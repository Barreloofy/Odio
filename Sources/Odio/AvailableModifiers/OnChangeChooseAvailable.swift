//
// OnChangeChooseAvailable.swift
// Odio
//
// Created by Barreloofy on 11/14/25 at 6:40 PM
//

import SwiftUI

struct OnChangeChooseAvailable<Value: Equatable>: ViewModifier {
  let value: Value
  let initial: Bool
  let action: () -> Void

  func body(content: Content) -> some View {
    if #available(iOS 17.0, macOS 14.0, *) {
      content
        .onChange(of: value, initial: initial, action)
    } else {
      content
        .onAppear { if initial { action() } }
        .onChange(of: value) { _ in action() }
    }
  }
}


extension View {
  func onChangeChooseAvailable(
    of value: some Equatable,
    initial: Bool = false,
    _ action: @escaping () -> Void)
  -> some View {
    modifier(
      OnChangeChooseAvailable(
        value: value,
        initial: initial,
        action: action))
  }
}
