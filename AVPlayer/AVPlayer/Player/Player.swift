//
//  Player.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 20.11.2022.
//

import UIKit
import AVFoundation

class Player {
    //MARK: singleton - shared
    static let shared = Player()
    //MARK: AVAudioPlayer
    var player: AVAudioPlayer?
    //MARK: func play with url
    func play(with audioPath: URL) {
        do {
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try? AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: audioPath)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    //MARK: func pause
    func pause() {
        player?.pause()
    }
    //MARK: func play with url at time
    func play(with audioPath: URL, at time: TimeInterval) {
        do {
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try? AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: audioPath)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play(atTime: time)
        } catch {
            print(error.localizedDescription)
        }
    }
}
