//
//  SecondTableViewCell.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 19.11.2022.
//

import UIKit
import AudioToolbox
import AVFoundation

class MusicControlTableViewCell: UITableViewCell {
    //MARK: player
    let player = Player.shared
    //MARK: properties
    var musicPath: URL?
    var currentSong: MainMusicListModel?
    var pausedTime =  0.0
    static var timer: Timer?
    //MARK: enum with clouser to PlayerVC
    enum OnChangeSongButtonPressed {
        case next(Int)
        case previous(Int)
    }
    
    var songChangesClouser: ((OnChangeSongButtonPressed) -> Void)?
    //MARK:   @IBOutlet weak var
    @IBOutlet weak var durationSliderOutlet: UISlider!{
        didSet {
            durationSliderOutlet.minimumValue = 0.0
            durationSliderOutlet.value = 0
        }
    }
    
    @IBOutlet weak var volumeSliderOutlet: UISlider! {
        didSet {
            volumeSliderOutlet.minimumValue = 0
            volumeSliderOutlet.value = 0.5
            volumeSliderOutlet.maximumValue = 1
        }
    }
    
    @IBOutlet weak var songTimePassedLabel: UILabel! {
        didSet {
            songTimePassedLabel.text = "00:00"
        }
    }
    
    @IBOutlet weak var songTimeLeftLabel: UILabel! {
        didSet {
            songTimeLeftLabel.text = "00:00"
        }
    }
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAuthorNameLabel: UILabel!
    @IBOutlet weak var playButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //MARK: @IBAction func
    @IBAction func songDurationSliderValueChanged(_ sender:  Any) {
        pausedTime = Double(durationSliderOutlet.value)
        durationSliderOutlet.maximumValue = Float(player.player?.duration ?? 0.0)
        player.player?.currentTime = TimeInterval(durationSliderOutlet.value)
    }
    
    @IBAction func playOrPauseButtonPressed(_ sender: Any) {
        if player.player?.isPlaying == true {
            player.pause()
            MusicControlTableViewCell.timer?.invalidate()
            pausedTime = Double(durationSliderOutlet.value)
            playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
        } else  {
            durationSliderOutlet.value = Float(pausedTime)
            player.play(with: musicPath ?? URL(fileURLWithPath: ""), at: TimeInterval(pausedTime))
            MusicControlTableViewCell.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(labelTimer), userInfo: nil, repeats: true)
            durationSliderOutlet.maximumValue = Float(player.player?.duration ?? 0.0)
            player.player?.currentTime = TimeInterval(durationSliderOutlet.value)
            playButtonOutlet.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }
    //MARK: @objc func labelTimer
    @objc func labelTimer(timer: Timer) {
        songTimePassedLabel.text = String(pausedTime)
        songTimeLeftLabel.text = String(Double((player.player?.duration ?? 0 )) - pausedTime)
        durationSliderOutlet.value = Float(pausedTime)
        pausedTime += 1
        
        if pausedTime == player.player?.duration {
            pausedTime = 0.0
            timer.invalidate()
        }

        songTimeLeftLabel.text = configTimeInLabel(duration: (player.player?.duration ?? 0) - pausedTime)
        songTimePassedLabel.text = configTimeInLabel(duration: pausedTime)
    }
   
    @IBAction func previousSongButtonPressed(_ sender: Any) {
        MusicControlTableViewCell.timer?.invalidate()
        player.player?.stop()
        pausedTime = 0.0
        songChangesClouser?(.previous((currentSong?.songNumber ?? 0)))
    }
    @IBAction func nextSongButtonPressed(_ sender: Any) {
        MusicControlTableViewCell.timer?.invalidate()
        player.player?.stop()
        pausedTime = 0.0
        songChangesClouser?(.next((currentSong?.songNumber ?? 0)))
    }
    
    @IBAction func songVolumeSliderValueChanged(_ sender: Any) {
        player.player?.volume = volumeSliderOutlet.value
    }
    //MARK: configTimeInLabel func
    private func configTimeInLabel(duration: TimeInterval) -> String {
        let minutesTextOut = Int(duration) / 60 % 60
        let secondsTextOut = Int(duration) % 60
        let strDuration = String(format:"%02d:%02d", minutesTextOut, secondsTextOut)
        return strDuration
    }
    //MARK: func configCell
    func configCell(with model: MainMusicListModel) {
        songNameLabel.text = model.songName
        songAuthorNameLabel.text = model.authorName
        musicPath = model.songPath
        currentSong = model
        playButtonOutlet.setImage(UIImage(systemName: "play"), for: .normal)
        songTimePassedLabel.text = "00:00"
        songTimeLeftLabel.text = "00:00"
        durationSliderOutlet.value = 0
        pausedTime = 0
    }
}
