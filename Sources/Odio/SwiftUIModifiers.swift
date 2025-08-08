//
// SwiftUIModifiers.swift
// Odio
//
// Created by Barreloofy on 5/30/25 at 12:46 PM
//

import SwiftUI
import AVFoundation

struct SoundOnTap: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        TapGesture()
          .onEnded { audioPlayer() })
      .onAppear { audioPlayer = OdioPlayer(name) }
      .onDisappear { audioPlayer.stop() }
  }
}


struct SoundOnChange<T: Hashable>: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String
  let value: T

  func body(content: Content) -> some View {
    content
      .onChange(of: value) { audioPlayer() }
      .onAppear { audioPlayer = OdioPlayer(name) }
      .onDisappear { audioPlayer.stop() }
  }
}


struct SoundConditionally: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String
  let shouldPlay: Bool

  func body(content: Content) -> some View {
    content
      .onChange(of: shouldPlay) {
        guard shouldPlay else { return }
        audioPlayer()
      }
      .onAppear {
        audioPlayer = OdioPlayer(name)
        if shouldPlay { audioPlayer() }
      }
      .onDisappear { audioPlayer.stop() }
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
  public func soundFeedback(_ name: String, shouldPlay: @autoclosure () -> Bool) -> some View {
    modifier(SoundConditionally(name: name, shouldPlay: shouldPlay()))
  }

  /// Plays a sound when the attached view is tapped.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  public func soundFeedback(_ key: FileKey) -> some View {
    modifier(SoundOnTap(name: key()))
  }

  /// Plays a sound when trigger changes.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - trigger: The value to monitor for changes.
  public func soundFeedback(_ key: FileKey, trigger: some Hashable) -> some View {
    modifier(SoundOnChange(name: key(), value: trigger))
  }

  /// Plays a sound when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - shouldPlay: The value to monitor for true.
  public func soundFeedback(_ key: FileKey, shouldPlay: @autoclosure () -> Bool) -> some View {
    modifier(SoundConditionally(name: key(), shouldPlay: shouldPlay()))
  }
}
