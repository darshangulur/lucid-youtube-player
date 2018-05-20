//
//  YTPlayerViewController.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints
import youtube_ios_player_helper

class YTPlayerViewController: UIViewController {

    // MARK: - Private properties
    private let videoId: String
    private let playerView = YTPlayerView()

    // MARK: - Initializers
    init(videoId: String) {
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)

        playVideo()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private functions
    private func addSubviews() {
        view.addSubview(playerView)
        playerView.edgesToSuperview()
    }
}

fileprivate extension YTPlayerViewController {
    private func playVideo() {
        if playerView.load(withVideoId: self.videoId) {
            playerView.delegate = self
        }
    }
}

extension YTPlayerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
