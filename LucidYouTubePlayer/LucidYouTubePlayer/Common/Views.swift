//
//  Views.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/20/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import SwifterSwift

protocol ViewSeparating {}

final class DashedLineView: UIView, ViewSeparating {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.height(2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let lineWidth = self.bounds.height
        let y = Int(lineWidth / 2.0)

        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(self.bounds.height)
        context.setLineDash(phase: 0, lengths: [1, CGFloat(lineWidth * 2) + 0.75])
        context.setLineCap(.round)
        context.setStrokeColor(Stylesheet.Color.secondaryGray.cgColor)
        context.move(to: CGPoint(x: 0, y: y))
        context.addLine(to: CGPoint(x: Int(self.bounds.size.width), y: y))
        context.strokePath()
    }
}

final class SolidLineView: UIView, ViewSeparating {

    enum Direction {
        case horizontal
        case vertical
    }

    init(frame: CGRect = .zero, direction: Direction = .horizontal, weight: CGFloat = 1.25.cgFloat) {
        super.init(frame: frame)
        self.backgroundColor = Stylesheet.Color.secondaryGray

        switch direction {
        case .horizontal: self.height(weight)
        case .vertical: self.width(weight)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
