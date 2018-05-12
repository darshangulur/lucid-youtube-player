//
//  ViewController.swift
//  LucidPlaylistPlayer
//
//  Created by Darshan Gulur Srinivasa on 4/16/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import Alamofire
import youtube_ios_player_helper

class ViewController: UIViewController {
    private var playerView = YTPlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        var pathString = "https://www.googleapis.com/youtube/v3/playlistItems"
        pathString.append("?part=snippet")
        pathString.append("&playlistId=PLOU2XLYxmsILwYAhwWBBdDEytdnE0d2-E")
        pathString.append("&maxResults=50")
        pathString.append("&key=AIzaSyDBK7Rf8Kup64cWymKwMZeAEOS_x_G0gCw")
        Alamofire.request(pathString).responseJSON { response in

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }

        self.view.addSubview(playerView)
        playerView.frame = view.frame

        if playerView.load(withVideoId: "R6yQBZlcNSw") {
            playerView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

