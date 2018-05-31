//
//  PlaylistResponse.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import Foundation

struct PlaylistResponse: Codable {

    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }

    struct Item: Codable {
        struct Snippet: Codable {
            struct Thumbnails: Codable {
                struct Default: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }

                struct Medium: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }

                struct High: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }

                struct Standard: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }

                let defaultValue: Default?
                let medium: Medium?
                let high: High?
                let standard: Standard?
            }

            struct ResourceId: Codable {
                let kind: String
                let videoId: String
            }

            let publishedAt: String
            let channelId: String
            let title: String
            let description: String
            let thumbnails: Thumbnails?
            let channelTitle: String
            let playlistId: String
            let position: Int
            let resourceId: ResourceId
        }

        struct ContentDetails: Codable {
            let videoId: String
            let videoPublishedAt: String
        }

        let kind: String
        let etag: String
        let id: String
        let snippet: Snippet
        let contentDetails: ContentDetails?
    }

    let kind: String
    let etag: String
    let nextPageToken: String
    let pageInfo: PageInfo
    let items: [Item]
}

extension PlaylistResponse.Item.Snippet.Thumbnails {
    var displayImageURL: URL? {
        func url(_ urlString: String?) -> URL? {
            guard let string = urlString, let url = URL(string: string) else { return nil }
            return url
        }
        return [self.standard?.url, self.high?.url, self.medium?.url, self.defaultValue?.url]
            .compactMap { url($0) }.first
    }
}
