//
//  ViewController.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 16.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: MainTableViewCell cellIdentifier
    private let cellIdentifier = "MainTableViewCell"
    //MARK: @IBOutlet weak var tableView
    @IBOutlet weak var tableView: UITableView!
    //MARK: properties
    var musicList: [MainMusicListModel] = MockDataHelper.shared.mockMusicList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    //MARK: private func setupTableView & registerCell
    private func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        registerCell(with: cellIdentifier)
    }
    private func registerCell(with cellIdentifier: String) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
    }
}
     //MARK: extension UITableViewDelegate
extension MainViewController: UITableViewDelegate {}
     //MARK: extension UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    //MARK: numberOfRowsInSection func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicList.count
    }
    //MARK: cellForRowAt func
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.completionHandler = { [weak self] isPressed, currentSong in
            if isPressed {
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
                vc?.currentSong = currentSong
                self?.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            }
        }
        cell.configCell(with: musicList[indexPath.row])
        return cell
    }
}

