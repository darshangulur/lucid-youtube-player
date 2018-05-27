//
//  ViewController.swift
//  LucidPlaylistPlayer
//
//  Created by Darshan Gulur Srinivasa on 4/16/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints
import SVProgressHUD

final class PlaylistViewController: UIViewController {
    
    // MARK: - Private properties
    private var categories = [String]()
    private var videos: [String: [PlaylistResponse.Item]] = [:]
    
    private lazy var tableView: UITableView = {
        $0.register(PlaylistRow.self, forCellReuseIdentifier: PlaylistRow.className)
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero))
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Playlists"
        self.view.backgroundColor = Stylesheet.Color.primaryWhite
        
        addSubViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(configureNewTapped))
        fetchPlaylist()
    }
    
    // MARK: - Private properties
    private func addSubViews() {
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
    @objc private func configureNewTapped(sender: UIBarButtonItem) {
        let configureNewViewController =  ConfigureNewPlaylistViewController { [weak self] playlistId, completion in
            var playlistIds = [String]()
            if let storedPlaylistIds = UserDefaults.standard.stringArray(forKey: "playlistIds") {
                playlistIds.append(contentsOf: storedPlaylistIds)
            }
            
            if !playlistIds.contains(playlistId) {
                playlistIds.append(playlistId)
                UserDefaults.standard.setValue(playlistIds, forKey: "playlistIds")
                self?.fetchPlaylist { success in
                    if success {
                        self?.navigationController?.topViewController?.dismiss(animated: true)
                        completion(.added)
                    } else {
                        completion(.invalid)
                    }
                }
            } else {
                completion(.duplicate)
            }
        }
        
        configureNewViewController.modalPresentationStyle = .popover
        configureNewViewController.preferredContentSize = CGSize(width: 600, height: 200)
        self.present(configureNewViewController, animated: true, completion: nil)
        
        let popoverPresentationViewController = configureNewViewController.popoverPresentationController
        popoverPresentationViewController?.delegate = self
        popoverPresentationViewController?.permittedArrowDirections = .up
        popoverPresentationViewController?.barButtonItem = sender
    }
}

extension PlaylistViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(title: categories[section])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return categories.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistRow.className, for: indexPath) as! PlaylistRow
        cell.configure(items: self.videos[self.categories[indexPath.section]] ?? []) { item in
            let player = YTPlayerViewController(videoTitle: item.snippet.title, videoId: item.snippet.resourceId.videoId)
            self.navigationController?.pushViewController(player)
        }
        return cell
    }
}

extension PlaylistViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

fileprivate extension PlaylistViewController {
    private func fetchPlaylist(completion: ((Bool) -> Void)? = nil) {
        guard var playlistIds = UserDefaults.standard.stringArray(forKey: "playlistIds") else { return }
        
        self.categories.removeAll()
        self.videos.removeAll()
        
        let playlistRepository: PlaylistSourcing = PlaylistRepository()
        let dispatchGroup = DispatchGroup()
        
        playlistIds.enumerated().forEach {
            dispatchGroup.enter();
            let playlistItem = $0
            let pathString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistItem.element)&maxResults=50&key=AIzaSyDBK7Rf8Kup64cWymKwMZeAEOS_x_G0gCw"
            
            print(pathString)
            SVProgressHUD.show()
            playlistRepository.fetchPlaylist(forURL: pathString) { [weak self] playlistResponse in
                guard let response = playlistResponse, let firstItem = response.items.first else {
                    playlistIds.removeAll(playlistItem.element)
                    UserDefaults.standard.setValue(playlistIds, forKey: "playlistIds")
                    completion?(false)
                    dispatchGroup.leave(); return
                }
                
                self?.categories.append(firstItem.snippet.channelTitle)
                self?.videos.updateValue(response.items, forKey: firstItem.snippet.channelTitle)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            completion?(true)
        }
    }
}

extension PlaylistViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle { return .none }
}
