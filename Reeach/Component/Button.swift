//
//  Button.swift
//  Reeach
//
//  Created by Balqis on 19/10/22.
//

import UIKit

class Button: UIButton {
    
    enum Style {
        case circle
        case rounded
    }
    
    enum Foreground {
        case primary
        case secondary
    }
    
    enum Background {
        case tangerineYellow
        case royalHunterBlue
        case tangelo
        case caribbeanGreen
        case darkSlateGrey
        case ghostWhite
    }
    
    public private(set) var style: Style
    public private(set) var foreground: Foreground
    public private(set) var background: Background
    public private(set) var title: String
    
    init(style: Style, foreground: Foreground, background: Background, title: String) {
        self.style = style
        self.foreground = foreground
        self.background = background
        self.title = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buttonSetup()
        handleStyleButton()
    }
    
    private func buttonSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
    }
    
    //style
    private var circleContentEdgeInsets: UIEdgeInsets {
        UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    private var roundedContentEdgeInsets: UIEdgeInsets {
        UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    private func handleStyleButton() {
        switch style {
        case .circle:
            layer.cornerRadius = 24
            contentEdgeInsets = circleContentEdgeInsets
        case .rounded:
            layer.cornerRadius = 16
            contentEdgeInsets = roundedContentEdgeInsets
        }
    }
    
    // background-foreground
    private func handleForegroundButton() {
        switch foreground {
        case .primary:
            UIFont.headline
            setTitleColor(UIColor.darkSlateGrey, for: .normal)
        case .secondary:
            UIFont.headline
            setTitleColor(UIColor(named: "primary7"), for: .normal)
        }
    }
    
    private func handleBackgroundButton() {
        switch background {
        case .tangerineYellow:
            backgroundColor = .tangerineYellow
        case .royalHunterBlue:
            backgroundColor = .royalHunterBlue
        case .tangelo:
            backgroundColor = .tangelo
        case .caribbeanGreen:
            backgroundColor = .caribbeanGreen
        case.darkSlateGrey:
            backgroundColor = .darkSlateGrey
        case.ghostWhite:
            backgroundColor = .ghostWhite
        }
    }
    
    
}
