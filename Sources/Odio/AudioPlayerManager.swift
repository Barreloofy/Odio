//
// AudioPlayerManager.swift
// Odio
//
// Created by Barreloofy on 5/30/25 at 12:11 PM
//

/*
import AVFoundation

@MainActor
class AudioPlayerManager: NSObject, @preconcurrency AVAudioPlayerDelegate {
  static let shared = AudioPlayerManager()
  private override init() {}

  private var players = Set<AVAudioPlayer>()

  func play(_ name: String, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    guard let player = createPlayer(name: name, bundle: bundle) else { return }

    player.delegate = self

    players.insert(player)

    player.prepareToPlay()
    player.play(atTime: player.deviceCurrentTime + delay)
  }

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    players.remove(player)
  }
}

@MainActor
public func play(_ name: String, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
  AudioPlayerManager.shared.play(name, after: delay, from: bundle)
}
*/
