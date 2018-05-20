//
//  Extensions.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/20/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import Foundation

extension NSObject {
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
