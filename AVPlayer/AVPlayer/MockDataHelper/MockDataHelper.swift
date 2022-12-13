//
//  MockData.swift
//  AVPlayer
//
//  Created by Baidetskyi Jurii on 16.11.2022.
//

import Foundation

class MockDataHelper {
    //MARK: singleton - shared
    static var shared = MockDataHelper()
    //MARK:  func mockMusicList
    func mockMusicList () -> [MainMusicListModel] {
        return [
            MainMusicListModel(songImage: "WhoMadeWho",
                               songName: "WhoMadeWho",
                               authorName: "Abu Simbel",
                               songPath: Bundle.main.url(forResource: "Abu Simbel - WhoMadeWho", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 0),
            MainMusicListModel(songImage: "Tokyo Cherry",
                               songName: "Tokyo Cherry",
                               authorName: "Alexander Alar & Sonita",
                               songPath: Bundle.main.url(forResource: "Alexander Alar & Sonita - Tokyo Cherry", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 1),
            MainMusicListModel(songImage: "Чому",
                               songName: "Чому( feat. Jerry Heil)",
                               authorName: "alyona alyona",
                               songPath: Bundle.main.url(forResource: "alyona alyona  - Чому( feat. Jerry Heil)", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 2),
            MainMusicListModel(songImage: "No time to die",
                               songName: "No Time To Die",
                               authorName: "Billie Eilish",
                               songPath: Bundle.main.url(forResource: "Billie Eilish - No Time To Die", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 3),
            MainMusicListModel(songImage: "Six Feet Under",
                               songName: "Six Feet Under",
                               authorName: "Billie Eilish",
                               songPath: Bundle.main.url(forResource: "Billie Eilish - Six Feet Under", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 4),
            MainMusicListModel(songImage: "Castle",
                               songName: "Castle",
                               authorName: "Halsey",
                               songPath: Bundle.main.url(forResource: "Halsey - Castle", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 5),
            MainMusicListModel(songImage: "Black Sea",
                               songName: "Black Sea",
                               authorName: "Natashe Blum",
                               songPath: Bundle.main.url(forResource: "Natashe Blum - Black Sea", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 6),
            MainMusicListModel(songImage: "Home",
                               songName: "Home (Boys Noize Remix)",
                               authorName: "Solomun",
                               songPath: Bundle.main.url(forResource: "Solomun - Home (Boys Noize Remix)", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 7),
            MainMusicListModel(songImage: "Young",
                               songName: "Young",
                               authorName: "The Chainsmokers",
                               songPath: Bundle.main.url(forResource: "The Chainsmokers - Young", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 8),
            MainMusicListModel(songImage: "Can You Hear Me ",
                               songName: "Can You Hear Me (feat. Young Summer)",
                               authorName: "UNSECRET",
                               songPath: Bundle.main.url(forResource: "UNSECRET- Can You Hear Me (feat. Young Summer)", withExtension: "mp3") ?? URL(fileURLWithPath: ""),
                               songNumber: 9)
        ]
    }
}

