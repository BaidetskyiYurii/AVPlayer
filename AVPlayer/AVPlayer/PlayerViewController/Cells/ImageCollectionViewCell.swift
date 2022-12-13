//
//  FirstCollectionViewCell.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 19.11.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK: @IBOutlet weak var
    @IBOutlet weak var songImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: func configCell with model
    func configCell(with model: MainMusicListModel) {
        self.songImage.image = UIImage(named: model.songImage)
    }
}
