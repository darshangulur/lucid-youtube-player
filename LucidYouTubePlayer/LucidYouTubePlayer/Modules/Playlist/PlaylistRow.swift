//
//  CategoryRow.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints

final class PlaylistRow : UITableViewCell {

    // MARK: - Private properties
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 20
        $0.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return $0
    }(UICollectionViewFlowLayout())

    private lazy var collectionView: UICollectionView = {
        $0.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.className)
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: flowLayout))

    private var items = [PlaylistResponse.Item]()
    private var didTapHandler: ((PlaylistResponse.Item) -> Void) = {_ in }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func addSubViews() {
        self.contentView.addSubview(collectionView)
        collectionView.edgesToSuperview()

        let dashedLineView = DashedLineView()
        self.addSubview(dashedLineView)
        dashedLineView.edgesToSuperview(excluding: .top)
    }

    // MARK: - Public functions
    func configure(items: [PlaylistResponse.Item], didTapHandler: @escaping ((PlaylistResponse.Item) -> Void)) {
        self.items = items
        self.didTapHandler = didTapHandler
    }
}

extension PlaylistRow : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.className,
                                                      for: indexPath) as! VideoCell
        cell.configure(item: items[indexPath.item])
        return cell
    }
}

extension PlaylistRow : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = 4.cgFloat
        let hardCodedPadding = 25.cgFloat
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - hardCodedPadding
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension PlaylistRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapHandler(items[indexPath.item])
    }
}
