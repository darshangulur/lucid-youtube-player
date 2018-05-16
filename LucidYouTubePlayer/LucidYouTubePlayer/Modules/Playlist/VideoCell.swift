//
//  VideoCell.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
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
}
