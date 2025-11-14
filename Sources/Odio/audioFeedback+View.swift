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
          .onEnded {
            audioPlayer.rewind()
            audioPlayer()
          })
      .onAppear {
        audioPlayer = OdioPlayer(for: name, after: delay)
      }
      .onDisappear {
        audioPlayer.end()
      }
  }
}


struct AudioOnChange<Value: Equatable>: ViewModifier {
  @AudioPlayer private var audioPlayer

  let name: String
  let delay: TimeInterval
  let value: Value

  func body(content: Content) -> some View {
    content
      .onChangeChooseAvailable(of: value) {
        audioPlayer.rewind()
        audioPlayer()
      }
      .onAppear {
        audioPlayer = OdioPlayer(for: name, after: delay)
      }
      .onDisappear {
        audioPlayer.end()
      }
  }
}


struct AudioConditionally: ViewModifier {
  struct PlaybackTrigger: Equatable {
    let id = UUID()
    let value: Bool

    init(condition: () -> Bool) {
      value = condition()
    }

    func callAsFunction() -> Bool { value }
  }

  @AudioPlayer private var audioPlayer

  let name: String
  let delay: TimeInterval
  let shouldPlay: PlaybackTrigger

  func body(content: Content) -> some View {
    content
      .onChangeChooseAvailable(of: shouldPlay) {
        guard shouldPlay() else { return }
        audioPlayer.rewind()
        audioPlayer()
      }
      .onAppear {
        audioPlayer = OdioPlayer(for: name, after: delay)
        if shouldPlay() { audioPlayer() }
      }
      .onDisappear {
        audioPlayer.end()
      }
  }
}


extension View {
  /// Plays audio when the attached view is tapped.
  /// - Parameters:
  ///   - fileName: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  public func audioFeedback(
    _ fileName: String,
    after delay: TimeInterval = 0) -> some View {
      modifier(
        AudioOnTap(
          name: fileName,
          delay: delay))
    }

  /// Plays audio when `trigger` changes.
  /// - Parameters:
  ///   - fileName: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(
    _ fileName: String,
    after delay: TimeInterval = 0,
    trigger: some Equatable) -> some View {
      modifier(
        AudioOnChange(
          name: fileName,
          delay: delay,
          value: trigger))
    }

  /// Plays audio when `shouldPlay` is evaluated to true.
  /// - Parameters:
  ///   - fileName: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(
    _ fileName: String,
    after delay: TimeInterval = 0,
    shouldPlay: () -> Bool) -> some View {
      modifier(
        AudioConditionally(
          name: fileName,
          delay: delay,
          shouldPlay: .init(condition: shouldPlay)))
    }

  /// Plays audio when the attached view is tapped.
  /// - Parameters:
  ///   - keyPath: A key path to a specific resulting value representing an audio file.
  ///   - delay: The time in seconds before playback occurs.
  public func audioFeedback(
    _ keyPath: KeyPath<FileKey, String>,
    after delay: TimeInterval = 0) -> some View {
      modifier(
        AudioOnTap(
          name: FileKey()[keyPath: keyPath],
          delay: delay))
    }

  /// Plays audio when `trigger` changes.
  /// - Parameters:
  ///   - keyPath: A key path to a specific resulting value representing an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - trigger: The value to monitor for changes.
  public func audioFeedback(
    _ keyPath: KeyPath<FileKey, String>,
    after delay: TimeInterval = 0,
    trigger: some Equatable) -> some View {
      modifier(
        AudioOnChange(
          name: FileKey()[keyPath: keyPath],
          delay: delay,
          value: trigger))
    }

  /// Plays audio when `shouldPlay` is evaluated to true.
  /// - Parameters:
  ///   - keyPath: A key path to a specific resulting value representing an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - shouldPlay: The value to monitor for true.
  public func audioFeedback(
    _ keyPath: KeyPath<FileKey, String>,
    after delay: TimeInterval = 0,
    shouldPlay: () -> Bool) -> some View {
      modifier(
        AudioConditionally(
          name: FileKey()[keyPath: keyPath],
          delay: delay,
          shouldPlay: .init(condition: shouldPlay)))
    }
}
