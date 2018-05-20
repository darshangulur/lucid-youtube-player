//
//  VideoCell.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints

class VideoCell : UICollectionViewCell {
    
    private var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .blue
        return $0
    }(UIImageView())

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        self.contentView.addSubview(imageView)
        imageView.edgesToSuperview()
    }

    func configure() {

    }
}
