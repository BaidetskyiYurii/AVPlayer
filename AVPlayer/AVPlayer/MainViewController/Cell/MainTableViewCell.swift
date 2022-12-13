//
//  MainTableViewCell.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 16.11.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    //MARK: completionHandler to MainViewController
    var completionHandler: ((Bool, MainMusicListModel)-> Void)?
    //MARK: properties
    var buttonPressed: Bool = false
    var currentSong: MainMusicListModel?
    //MARK:  @IBOutlet weak var outlets
    @IBOutlet weak var songAuthorNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    //MARK:  @IBAction func
    @IBAction func playSongButtonPressed(_ sender: Any) {
        guard let currentSong = currentSong else {
            let musicList = MockDataHelper.shared.mockMusicList()
            currentSong = musicList[0]
            completionHandler?(true, currentSong ?? MainMusicListModel(songImage: "", songName: "", authorName: "", songPath: URL(filePath: ""), songNumber: 0))
            return
        }
        completionHandler?(true, currentSong)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //MARK: func configCell
    func configCell( with model: MainMusicListModel) {
        songImage.image = UIImage(named: model.songImage)
        songNameLabel.text = model.songName
        songAuthorNameLabel.text = model.authorName
        currentSong = model
    }
}
