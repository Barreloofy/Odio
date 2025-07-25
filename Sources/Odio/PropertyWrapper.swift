//
// PropertyWrapper.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 11:04 PM
//

import SwiftUI

/// A property wrapper that can playback audio.
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
  ///   - delay: The delay in seconds before the player starts playing.
  public init(delay: TimeInterval = 0) {
    self.player = .init(delay: delay)
  }
}
