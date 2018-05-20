//
//  ConfigureNewPlaylistViewController.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/20/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import TinyConstraints
import Closures

class ConfigureNewPlaylistViewController: UIViewController {

    private lazy var textField: UITextField = {
        $0.font = Stylesheet.Font.description
        $0.textColor = Stylesheet.Color.secondaryGray
        $0.layer.cornerRadius = 8.0
        $0.layer.borderColor = Stylesheet.Color.secondaryGray.cgColor
        $0.layer.borderWidth = 1.0
        return $0
    }(UITextField(frame: .zero))

    private lazy var titleLabel: UILabel = {
        $0.font = Stylesheet.Font.description
        $0.textColor = Stylesheet.Color.secondaryRed
        $0.textAlignment = .right
        $0.text = "Please correct the text"
        return $0
    }(UILabel(frame: .zero))

    private lazy var button: UIButton = {
        $0.setTitle("Validate", for: .normal)
        $0.titleLabel?.font = Stylesheet.Font.title
        $0.backgroundColor = Stylesheet.Color.secondaryOrange
        $0.tintColor = Stylesheet.Color.primaryWhite
        return $0
    }(UIButton(type: .custom))

    private let configureHandler: ((String) -> Void)

    // MARK: - Initializers
    init(configureHandler: @escaping ((String) -> Void)) {
        self.configureHandler = configureHandler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        bindActions()
    }

    // MARK: - Private functions
    private func addSubviews() {
        self.view.addSubviews([textField, titleLabel, button])

        textField.widthToSuperview(multiplier: 0.7)
        textField.centerXToSuperview()
        textField.topToSuperview(offset: 30)
        textField.height(40)

        titleLabel.topToBottom(of: textField, offset: 5)
        titleLabel.width(to: titleLabel)
        titleLabel.right(to: textField)

        button.width(to: textField)
        button.centerX(to: textField)
        button.topToBottom(of: titleLabel, offset: 20)
    }

    private func bindActions() {
        button.onTap {
            self.configureHandler(self.textField.text ?? "")
        }
    }
}
