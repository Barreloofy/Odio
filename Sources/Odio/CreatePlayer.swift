//
// GlobalFunctions.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 6:18 PM
//

import AVFoundation

/// Creates an AVAudioPlayer from the contents of a file.
/// - Parameters:
///   - name: The name of an audio file.
///   - bundle: The bundle to retrieve the file from.
/// - Returns: An initiated instance of AVAudioPlayer with the contents of the file, if an error occured nil.
public func createPlayer(name: String, bundle: Bundle = .main) -> AVAudioPlayer? {
  do {
    guard
      let url = bundle.url(forResource: name, withExtension: nil)
    else { throw OdioError.resourceNotFound("File: \(name) not found in bundle: \(bundle)") }

    let player = try AVAudioPlayer(contentsOf: url)

    player.prepareToPlay()
    return player

  } catch {
    errorLogger.error("\(error)")
    return nil
  }
}
