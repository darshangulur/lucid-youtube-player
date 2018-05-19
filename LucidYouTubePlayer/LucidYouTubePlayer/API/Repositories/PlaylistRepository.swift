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
    func fetchPlaylist(forURL urlString: String, completion: @escaping (PlaylistResponse?) -> Void)
}

final class PlaylistRepository: PlaylistSourcing {
    func fetchPlaylist(forURL urlString: String, completion: @escaping (PlaylistResponse?) -> Void) {
        Alamofire.request(urlString).responseJSON { response in
            if let data = response.data {
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
