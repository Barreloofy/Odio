//
// FileKey.swift
// Odio
//
// Created by Barreloofy on 8/8/25 at 4:10 PM
//

/// Extend `FileKey` with the name of a file, for safer and quicker access.
///
/// Insted of using the string literal directly create a static instance of `FileKey` to use in supported initializers.
/// ```swift
/// extension FileKey {
///   static let tapSound = FileKey(value: "TapSound.mp3")
/// }
/// ```
public struct FileKey: Sendable {
  public let value: String

  public init(value: String) {
    self.value = value
  }

  public func callAsFunction() -> String {
    value
  }
}
