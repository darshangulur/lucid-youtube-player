//
//  Stylesheet.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/13/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit

enum Stylesheet {
    enum Color {
        static let primaryGray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        static let primaryWhite = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        static let secondaryGray = UIColor(red:0.43, green:0.48, blue:0.51, alpha:1)
        static let secondaryRed = UIColor(red:1.0, green:0.0, blue:0.0, alpha:1)
        static let secondaryOrange = UIColor(red:1.00, green:0.48, blue:0.00, alpha:1.0)
    }

    enum Font {
        static let sectionHeader = UIFont(name: "Helvetica-bold", size: 20.0)
        static let title = UIFont(name: "Helvetica-bold", size: 16.0)
        static let description = UIFont(name: "Helvetica", size: 14.0)
    }
}
