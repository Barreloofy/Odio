//
// SwiftUIModifiers.swift
// Odio
//
// Created by Barreloofy on 5/30/25 at 12:46 PM
//

import SwiftUI

struct AudioOnTap: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String
  let delay: TimeInterval

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        TapGesture()
          .onEnded { audioPlayer() })
      .onAppear { audioPlayer = OdioPlayer(name, after: delay) }
      .onDisappear { audioPlayer.stop() }
  }
}


struct AudioOnChange<T: Hashable>: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String
  let delay: TimeInterval
  let value: T

  func body(content: Content) -> some View {
    content
      .onChange(of: value) { audioPlayer() }
      .onAppear { audioPlayer = OdioPlayer(name, after: delay) }
      .onDisappear { audioPlayer.stop() }
  }
}


struct AudioConditionally: ViewModifier {
  struct PlaybackTrigger: Equatable {
    let id = UUID()

    let value: Bool

    func callAsFunction() -> Bool { value }
  }

  @AudioPlayer private var audioPlayer

  let name: String
  let delay: TimeInterval
  let shouldPlay: PlaybackTrigger

  func body(content: Content) -> some View {
    content
      .onChange(of: shouldPlay) {
        guard shouldPlay() else { return }
        audioPlayer()
      }
      .onAppear {
        audioPlayer = OdioPlayer(name, after: delay)
        if shouldPlay() { audioPlayer() }
      }
      .onDisappear { audioPlayer.stop() }
  }
}


extension View {
  /// Plays audio when the attached view is tapped.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  public func audioFeedback(_ name: String, after delay: TimeInterval = 0) -> some View {
    modifier(AudioOnTap(name: name, delay: delay))
  }

  /// Plays audio when trigger changes.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(_ name: String, after delay: TimeInterval = 0, trigger: some Hashable) -> some View {
    modifier(AudioOnChange(name: name, delay: delay, value: trigger))
  }

  /// Plays audio when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(_ name: String, after delay: TimeInterval = 0, shouldPlay: () -> Bool) -> some View {
    modifier(AudioConditionally(name: name, delay: delay, shouldPlay: .init(value: shouldPlay())))
  }

  /// Plays audio when the attached view is tapped.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The time in seconds before playback occurs.
  public func audioFeedback(_ key: FileKey, after delay: TimeInterval = 0) -> some View {
    modifier(AudioOnTap(name: key(), delay: delay))
  }

  /// Plays audio when trigger changes.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(_ key: FileKey, after delay: TimeInterval = 0, trigger: some Hashable) -> some View {
    modifier(AudioOnChange(name: key(), delay: delay, value: trigger))
  }

  /// Plays audio when shouldPlay is evaluated as true.
  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(_ key: FileKey, after delay: TimeInterval = 0, shouldPlay: () -> Bool) -> some View {
    modifier(AudioConditionally(name: key(), delay: delay, shouldPlay: .init(value: shouldPlay())))
  }
}
