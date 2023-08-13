//
//  AudioPlayerService.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 8/13/23.
//

import AVFoundation
import Foundation

protocol AudioPlayerServiceProtocol {
  func playSound()
}

final class AudioPlayerService: AudioPlayerServiceProtocol {
  private var player: AVAudioPlayer?
  func playSound() {
    guard let path = Bundle.main.path(forResource: "click", ofType: "m4a") else { return }
    let url = URL(fileURLWithPath: path)
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
}
