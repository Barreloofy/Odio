//
// PropertyWrapper.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 11:04 PM
//

import SwiftUI

/// A property wrapper that can playback audio.
///
/// > Important:
/// The underlying player is stored in an `@State` property wrapper,
/// which has the side effect that repeated calls to the `@AudioPlayer` instance
/// will result in that not all calls to the instance will play audio, only once the previous call has finished playing.
///
/// Use the `FileKey` overload initializer to quickly and safely initialize a new `@AudioPlayer`.
///```swift
/// extension FileKey {
///   static let tapSound = FileKey(value: "TapSound.mp3")
/// }
///
/// @AudioPlayer(.tapSound) private var audioPlayer
///```
///
/// You can also initiate an empty `@AudioPlayer`, useful when the audio file to use is not known initially.
/// ```swift
/// struct SoundOnTap: ViewModifier {
///   @AudioPlayer private var audioPlayer
///
///   let name: String
///
///   func body(content: Content) -> some View {
///     content
///       .simultaneousGesture(
///         TapGesture()
///           .onEnded { audioPlayer() })
///       .onAppear { audioPlayer = OdioPlayer(name) }
///       .onDisappear { audioPlayer.stop() }
///   }
/// }
/// ```
///
/// Refer directly to an instance of `@AudioPlayer` to access its wrapped value.
/// ```swift
/// struct SoundView: View {
///   @AudioPlayer("TapSound.mp3") private var audioPlayer
///
///   var body: some View {
///       Button("Play Sound") { audioPlayer() }
///
///       Button("New Sound") { audioPlayer = .init("ThunderSound.mp3") }
///   }
/// }
/// ```
@MainActor
@propertyWrapper public struct AudioPlayer: DynamicProperty {
  @State private var player: OdioPlayer

  public var wrappedValue: OdioPlayer {
    get { player }
    nonmutating set { player = newValue }
  }

  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The delay in seconds before the player starts playing.
  ///   - bundle: The bundle to retrieve the file from.
  public init(_ name: String, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    self.player = .init(name, after: delay, from: bundle)
  }

  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The delay in seconds before the player starts playing.
  ///   - bundle: The bundle to retrieve the file from.
  public init(_ key: FileKey, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    self.player = .init(key(), after: delay, from: bundle)
  }

  public init() { player = .init() }
}
