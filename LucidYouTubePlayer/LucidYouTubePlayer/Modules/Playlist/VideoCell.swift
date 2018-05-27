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

final class VideoCell : UICollectionViewCell {

    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = Stylesheet.Color.primaryGray
        return $0
    }(UIImageView())

    private lazy var playerImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "playerIcon")
        return $0
    }(UIImageView())

    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 2
        $0.font = Stylesheet.Font.title
        return $0
    }(UILabel(frame: .zero))

    private lazy var descriptionLabel: UILabel = {
        $0.numberOfLines = 3
        $0.font = Stylesheet.Font.description
        $0.textColor = Stylesheet.Color.secondaryGray
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
        self.contentView.addSubviews([imageView, playerImageView, titleLabel, descriptionLabel])

        imageView.edgesToSuperview(excluding: .bottom)
        imageView.height(150)

        playerImageView.size(CGSize(width: 46, height: 36))
        playerImageView.left(to: imageView)
        playerImageView.bottom(to: imageView)

        titleLabel.edgesToSuperview(excluding: [.top, .bottom])
        titleLabel.topToBottom(of: imageView, offset: 10)

        descriptionLabel.edgesToSuperview(excluding: .top)
        descriptionLabel.topToBottom(of: titleLabel)
    }

    func configure(item: PlaylistResponse.Item) {
        imageView.sd_setImage(with: item.snippet.thumbnails?.displayImageURL, placeholderImage: nil)
        titleLabel.text = item.snippet.title
        descriptionLabel.text = item.snippet.description
    }
}

final class SectionHeaderView: UIView {

    // MARK: - Private properties
    private lazy var titleLabel: UILabel = {
        $0.font = Stylesheet.Font.sectionHeader
        return $0
    }(UILabel(frame: .zero))

    private let title: String

    // MARK: - Initializers
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        self.backgroundColor = Stylesheet.Color.primaryWhite


        addSubviews()
        configure()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Private functions
    private func addSubviews() {
        self.addSubview(titleLabel)
        titleLabel.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 40, bottom: 20, right: 40))
    }

    // MARK: - Public functions
    private func configure() { titleLabel.text = title }
}
