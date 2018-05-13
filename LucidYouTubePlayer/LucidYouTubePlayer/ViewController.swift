//
//  ViewController.swift
//  LucidPlaylistPlayer
//
//  Created by Darshan Gulur Srinivasa on 4/16/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints
import youtube_ios_player_helper

class ViewController: UIViewController {
    private var playerView = YTPlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let playlistRepository: PlaylistSourcing = PlaylistRepository()
        playlistRepository.fetchPlaylist(forURL: URL(string: "https://www.google.com")!) { responseModel in
//            print("\(responseModel?.pageInfo ?? nil)")
        }
//        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func addSubViews() {
        self.view.addSubview(playerView)
        playerView.edgesToSuperview()
    }

    private func playVideo() {
        if playerView.load(withVideoId: "R6yQBZlcNSw") {
            playerView.delegate = self
        }
    }
}

extension ViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

