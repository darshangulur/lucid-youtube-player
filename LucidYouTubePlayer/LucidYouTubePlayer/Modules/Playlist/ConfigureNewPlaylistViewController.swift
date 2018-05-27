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

final class ConfigureNewPlaylistViewController: UIViewController {

    private lazy var textField: UITextField = {
        $0.font = Stylesheet.Font.title
        $0.textColor = Stylesheet.Color.secondaryBlack
        $0.placeholder = "Tap to enter a playlist Id"
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.layer.cornerRadius = 8.0
        $0.layer.borderColor = Stylesheet.Color.secondaryGray.cgColor
        $0.layer.borderWidth = 2.0
        return $0
    }(UITextField(frame: .zero))

    private lazy var titleLabel: UILabel = {
        $0.font = Stylesheet.Font.description
        $0.textColor = Stylesheet.Color.secondaryRed
        $0.textAlignment = .right
        return $0
    }(UILabel(frame: .zero))

    private lazy var button: UIButton = {
        $0.setTitle("Add playlist", for: .normal)
        $0.titleLabel?.font = Stylesheet.Font.title
        $0.backgroundColor = Stylesheet.Color.secondaryOrange
        $0.tintColor = Stylesheet.Color.primaryWhite
        return $0
    }(UIButton(type: .custom))

    private let configureHandler: ((String, (@escaping (Bool) -> Void)) -> Void)

    // MARK: - Initializers
    init(configureHandler: @escaping ((String, (@escaping (Bool) -> Void)) -> Void)) {
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
        textField.text = "https://www.youtube.com/watch?v=VYOjWnS4cMY&list=PLx0sYbCqOb8QTF1DCJVfQrtWknZFzuoAE"
    }

    // MARK: - Private functions
    private func addSubviews() {
        self.view.addSubviews([textField, titleLabel, button])

        textField.widthToSuperview(multiplier: 0.7)
        textField.centerXToSuperview()
        textField.topToSuperview(offset: 40)
        textField.height(50)

        titleLabel.topToBottom(of: textField, offset: 5)
        titleLabel.width(to: titleLabel)
        titleLabel.right(to: textField)

        button.size(to: textField)
        button.centerX(to: textField)
        button.topToBottom(of: titleLabel, offset: 20)
    }

    private func bindActions() {
        button.onTap { [weak self] in
            guard let urlString = self?.textField.text,
                !urlString.isEmpty,
                let playlistId = self?.extractPlaylistId(urlString: urlString) else {
                self?.titleLabel.text = "Enter a valid playlist url"
                return
            }

            self?.configureHandler(playlistId) { status in
                self?.titleLabel.text = !status ? "Couldn't fetch playlist for the url": ""
            }
        }
    }
}

extension ConfigureNewPlaylistViewController {
    func extractPlaylistId(urlString: String) -> String? {
        guard let url = URL(string: urlString),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems else { return nil }

        guard let list = components[name: "list"], !list.isEmpty else { return nil }
        return list
    }
}

// MARK: - [URLQueryItem] custom subscript
extension Array where Element == URLQueryItem {
    subscript(name keyName: String) -> String? {
        get { return self.first(where: { $0.name == keyName })?.value }
        set { self.append(URLQueryItem(name: keyName, value: newValue)) }
    }
}
