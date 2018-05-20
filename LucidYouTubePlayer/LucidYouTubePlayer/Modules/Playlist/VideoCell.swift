//
//  VideoCell.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints
import  SDWebImage

class VideoCell : UICollectionViewCell {

    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = Stylesheet.Color.primaryGray
        return $0
    }(UIImageView())

    private var titleLabel: UILabel = {
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.font = Stylesheet.Font.title
        return $0
    }(UILabel(frame: .zero))

    private var descriptionLabel: UILabel = {
        $0.textAlignment = .left
        $0.numberOfLines = 3
        $0.font = Stylesheet.Font.description
        return $0
    }(UILabel(frame: .zero))

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
    }

    // MARK: - Private functions
    private func addSubviews() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)

        imageView.edgesToSuperview(excluding: .bottom)
        imageView.height(150)

        titleLabel.edgesToSuperview(excluding: [.top, .bottom])
        titleLabel.topToBottom(of: imageView, offset: 10)

        descriptionLabel.edgesToSuperview(excluding: .top)
        descriptionLabel.topToBottom(of: titleLabel, offset: 10)
    }

    func configure(item: PlaylistResponse.Item) {
        imageView.sd_setImage(with: item.snippet.thumbnails?.displayImageURL, placeholderImage: nil)
        titleLabel.text = item.snippet.title
        descriptionLabel.text = item.snippet.description
    }
}
