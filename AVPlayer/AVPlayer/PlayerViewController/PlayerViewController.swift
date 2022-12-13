//
//  PlayerViewController.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 19.11.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    //MARK: properties
    var musicList = MockDataHelper.shared.mockMusicList()
    var currentSong: MainMusicListModel? {
        didSet {
            guard let currentSong = currentSong, !items.isEmpty else {
                return
            }
            items[0] = .first(musicList, currentSong)
            items[1] = .second(currentSong)
        }
    }
    var isSongChanged = false
    //MARK: private enum PlayerTableCellType
    private enum PlayerTableCellType {
        case first([MainMusicListModel], MainMusicListModel)
        case second(MainMusicListModel)
        
        var nibName: String {
            switch self {
            case .first(_,_):
                return "MusicImageTableViewCell"
            case .second(_):
                return "MusicControlTableViewCell"
            }
        }
        
        var indentifier: String {
            switch self {
            case .first(_,_):
                return "MusicImageTableViewCell"
            case .second(_):
                return "MusicControlTableViewCell"
            }
        }
    }
    //MARK: private PlayerTableCellType array
    private var items = [PlayerTableCellType]()
    //MARK: @IBOutlet weak var tableView
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    //MARK: loadData
    func loadData() {
        guard let currentSong = currentSong else {
            showAlertWithOneButton(message: "Somethig went wrong", title: "Try Again", okActionHandler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        items.append(.first(musicList, currentSong))
        items.append(.second(currentSong))
        configTableView()
        tableView.reloadData()
        
    }
    //MARK:  private func configTableView
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        items.forEach{ tableView.register(UINib(nibName: $0.nibName, bundle: nil),
                                          forCellReuseIdentifier: $0.indentifier)}
        tableView.reloadData()
    }
}
//MARK: extension UITableViewDelegate
extension PlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return  CGFloat(350)
        } else if indexPath.row == 1 {
            return  CGFloat(400)
        }
        return  view.bounds.height
    }
}
//MARK: extension UITableViewDataSource
extension PlayerViewController: UITableViewDataSource {
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: items.indentifier)
        
        switch items {
            //MARK: first cell
        case let .first(musicList, currentSong):
            guard let cell = cell as? MusicImageTableViewCell else {
                return UITableViewCell()
            }
            //MARK: config first cell
            cell.configCell(with: musicList, currentSong: currentSong)
            //MARK: notification from first cell
            cell.currentSongHandler = { [weak self] newCurrentSong, isChanged in
                self?.currentSong = newCurrentSong
                self?.isSongChanged = isChanged
                MusicControlTableViewCell.timer?.invalidate()
                Player.shared.player?.stop()
                let indexPosition = IndexPath(row: 1, section: 0)
                tableView.reloadRows(at: [indexPosition], with: .none)
            }
            //MARK: config first cell
        case let .second(currentSong):
            guard let cell = cell as? MusicControlTableViewCell else {
                return UITableViewCell()
            }
            //MARK: notification from second cell
            cell.songChangesClouser = { [weak self] songIndex in
                switch songIndex {
                case let .next(index) where index < (self?.musicList.count ?? 0) - 1:
                    self?.currentSong = self?.musicList[index + 1]
                case let .previous(index) where index > 0 :
                    self?.currentSong = self?.musicList[index - 1]
                default: break
                }
                let indexPosition = IndexPath(row: 0, section: 0)
                tableView.reloadRows(at: [indexPosition], with: .none)
            }
            //MARK: config second cell
            cell.configCell(with: currentSong)
        }
        return cell ?? UITableViewCell()
    }
}
