//
//  ViewController.swift
//  LucidPlaylistPlayer
//
//  Created by Darshan Gulur Srinivasa on 4/16/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints

class PlaylistViewController: UIViewController {

    // MARK: - Private properties
    private var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    private lazy var tableView: UITableView = {
        $0.register(CategoryRow.self, forCellReuseIdentifier: "CategoryRow")
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: .zero))

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Playlist"
        self.view.backgroundColor = Stylesheet.Color.primaryWhite

        addSubViews()
        fetchPlaylist()
    }

    // MARK: - Private properties
    private func addSubViews() {
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}

extension PlaylistViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryRow", for: indexPath) as! CategoryRow
        return cell
    }

}

extension PlaylistViewController : UITableViewDelegate { }

fileprivate extension PlaylistViewController {
    private func fetchPlaylist() {
        let playlistRepository: PlaylistSourcing = PlaylistRepository()
        var pathString = "https://www.googleapis.com/youtube/v3/playlistItems"
        pathString.append("?part=snippet")
        pathString.append("&playlistId=PLBCF2DAC6FFB574DE")
        pathString.append("&maxResults=50")
        pathString.append("&key=AIzaSyDBK7Rf8Kup64cWymKwMZeAEOS_x_G0gCw")
        playlistRepository.fetchPlaylist(forURL: pathString) { responseModel in }
    }
}
