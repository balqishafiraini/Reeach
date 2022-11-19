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
        case destructive
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
    public private(set) var textColor: UIColor?
    public private(set) var backColor: UIColor?
    public private(set) var title: String?
    public private(set) var image: UIImage?
    
    init(style: Style, foreground: Foreground, background: Background, title: String? = nil, image: UIImage? = nil, textColor: UIColor? = nil, backColor: UIColor? = nil) {
        self.style = style
        self.foreground = foreground
        self.background = background
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backColor = backColor
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buttonSetup()
        handleStyleButton()
        handleForegroundButton()
        handleBackgroundButton()
    }
    
    private func buttonSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
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
            layer.cornerRadius = frame.width/2
            contentEdgeInsets = circleContentEdgeInsets
        case .rounded:
            layer.cornerRadius = 16
            contentEdgeInsets = roundedContentEdgeInsets
        }
    }
    
    // background-foreground
    private func handleForegroundButton() {
        if let color = textColor {
            setTitleColor(color, for: .normal)
            titleLabel?.font = .headline
        } else {
            switch foreground {
                case .primary:
                    setTitleColor(UIColor.darkSlateGrey, for: .normal)
                    titleLabel?.font = .headline
                case .secondary:
                    setTitleColor(UIColor.primary7, for: .normal)
                    titleLabel?.font = .headline
                case .destructive:
                    setTitleColor(UIColor.ghostWhite, for: .normal)
                    titleLabel?.font = .headline
            }
        }
    }
    
    private func handleBackgroundButton() {
        if let color = backColor {
            backgroundColor = color
        } else {
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
    
    func setButtonByStatus(isEnabled: Bool, backColor: UIColor, textColor: UIColor) {
        backgroundColor = backColor
        setTitleColor(textColor, for: isEnabled ? .normal : .disabled)
        titleLabel?.font = isEnabled ? .bodyBold : .bodyMedium
        
        self.isEnabled = isEnabled
    }
    
}
