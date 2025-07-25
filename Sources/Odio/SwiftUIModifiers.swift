//
// SwiftUIModifiers.swift
// Odio
//
// Created by Barreloofy on 5/30/25 at 12:46 PM
//

import SwiftUI
import AVFoundation

struct SoundOnTap: ViewModifier {
  @AudioPlayer private var odioplayer

  let name: String

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        TapGesture()
          .onEnded { odioplayer() }
      )
      .onAppear { odioplayer = OdioPlayer(name) }
      .onDisappear { odioplayer.stop() }
  }
}


struct SoundOnChange<T: Hashable>: ViewModifier {
  @AudioPlayer private var odioplayer

  let name: String
  let value: T

  func body(content: Content) -> some View {
    content
      .onChange(of: value) { odioplayer() }
      .onAppear { odioplayer = OdioPlayer(name) }
      .onDisappear { odioplayer.stop() }
  }
}


struct SoundConditionally: ViewModifier {
  @AudioPlayer private var odioplayer

  let name: String
  let shouldPlay: Bool

  func body(content: Content) -> some View {
    content
      .onChange(of: shouldPlay, initial: true) {
        guard shouldPlay else { return }
        odioplayer()
      }
      .onAppear { odioplayer = OdioPlayer(name) }
      .onDisappear { odioplayer.stop() }
  }
}


extension View {
  /// Plays a sound when the attached view is tapped.
  /// - Parameters:
  ///   - name: The name of an audio file.
  public func soundFeedback(_ name: String) -> some View {
    modifier(SoundOnTap(name: name))
  }

  /// Plays a sound when trigger changes.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - trigger: The value to monitor for changes.
  public func soundFeedback(_ name: String, trigger: some Hashable) -> some View {
    modifier(SoundOnChange(name: name, value: trigger))
  }

  /// Plays a sound when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - shouldPlay: The value to monitor for true.
  public func soundFeedback(_ name: String, shouldPlay: Bool) -> some View {
    modifier(SoundConditionally(name: name, shouldPlay: shouldPlay))
  }
}
