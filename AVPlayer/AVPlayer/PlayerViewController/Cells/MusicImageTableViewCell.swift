//
//  FirstTableViewCell.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 19.11.2022.
//

import UIKit

class MusicImageTableViewCell: UITableViewCell {
    //MARK:  @IBOutlet weak var
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK: properties
    var songList = [MainMusicListModel]()
    var currentSong: MainMusicListModel?
    var songChanged = false
    var thisWidth:CGFloat = 0
    //MARK: clouser to PlayerViewController
    var currentSongHandler: ((MainMusicListModel, Bool) -> Void)?
    //MARK: ImageCollectionViewCell cellID
    private let cellID = "ImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thisWidth = CGFloat(self.frame.width)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil),
                                forCellWithReuseIdentifier: cellID)
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = songList.count
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //MARK: func configCell
    func configCell(with model: [MainMusicListModel], currentSong: MainMusicListModel) {
        self.songList = model
        self.currentSong = currentSong
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            self.collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: IndexPath(item: currentSong.songNumber, section: 0), at: .centeredHorizontally, animated: true)
            self.collectionView.isPagingEnabled = true
        })
    }
}
    //MARK: extension UICollectionViewDelegate
extension MusicImageTableViewCell: UICollectionViewDelegate {}
    //MARK: extension UICollectionViewDataSource
extension MusicImageTableViewCell: UICollectionViewDataSource {
    //MARK: numberOfItemsInSection func
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songList.count
    }
    //MARK: cellForItemAt func
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentSong = songList[indexPath.row]
            cell.configCell(with: currentSong)
        return cell
    }
}
   //MARK: extension UICollectionViewDelegateFlowLayout
extension MusicImageTableViewCell: UICollectionViewDelegateFlowLayout {
    //MARK: willDisplay cell func
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        let selectedSong = songList[indexPath.row]
        currentSongHandler?(selectedSong, true)
    }
    //MARK: layout collectionViewLayout func
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.frame.width)
            return CGSize(width: thisWidth , height: self.frame.height )
    }
    // functions to config presentation of page control
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
//            self.pageControl.currentPage = visibleIndexPath.row
//        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       guard scrollView != collectionView else { return }
//        let pageIndex = round(scrollView.contentOffset.x/self.frame.width)
//       pageControl.currentPage = Int(pageIndex)
//    }
}
