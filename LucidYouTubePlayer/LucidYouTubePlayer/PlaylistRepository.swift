//
//  PlaylistRepository.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/12/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import Alamofire

protocol PlaylistSourcing {
    func fetchPlaylist(forURL url: URL, completion: @escaping (PlaylistResponse?) -> Void)
}

final class PlaylistRepository: PlaylistSourcing {

    init() {}

    func fetchPlaylist(forURL url: URL, completion: @escaping (PlaylistResponse?) -> Void) {
        var pathString = "https://www.googleapis.com/youtube/v3/playlistItems"
        pathString.append("?part=snippet")
        pathString.append("&playlistId=PLBCF2DAC6FFB574DE")
        pathString.append("&maxResults=50")
        pathString.append("&key=AIzaSyDBK7Rf8Kup64cWymKwMZeAEOS_x_G0gCw")
        Alamofire.request(pathString).responseJSON { response in

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(PlaylistResponse.self, from: data)
                    completion(responseModel)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }

}
