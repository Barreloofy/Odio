//
// SwiftUIModifiers.swift
// Odio
//
// Created by Barreloofy on 5/30/25 at 12:46 PM
//

import SwiftUI
import AVFoundation

struct AudioOnTap: ViewModifier {
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


struct AudioOnChange<T: Hashable>: ViewModifier {
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


struct AudioConditionally: ViewModifier {
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
  public func audioFeedback(_ name: String) -> some View {
    modifier(AudioOnTap(name: name))
  }

  /// Plays a sound when trigger changes.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(_ name: String, trigger: some Hashable) -> some View {
    modifier(AudioOnChange(name: name, value: trigger))
  }

  /// Plays a sound when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(_ name: String, shouldPlay: () -> Bool) -> some View {
    modifier(AudioConditionally(name: name, shouldPlay: shouldPlay()))
  }

  /// Plays a sound when the attached view is tapped.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  public func audioFeedback(_ key: FileKey) -> some View {
    modifier(AudioOnTap(name: key()))
  }

  /// Plays a sound when trigger changes.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(_ key: FileKey, trigger: some Hashable) -> some View {
    modifier(AudioOnChange(name: key(), value: trigger))
  }

  /// Plays a sound when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(_ key: FileKey, shouldPlay: () -> Bool) -> some View {
    modifier(AudioConditionally(name: key(), shouldPlay: shouldPlay()))
  }
}
