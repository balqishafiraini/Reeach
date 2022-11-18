//
//  EmojiKeyboardTextField.swift
//  Reeach
//
//  Created by Balqis on 16/11/22.
//

import UIKit

class UIEmojiTextField: UITextField {
    override var textInputContextIdentifier: String? {
        return "emojiTextInputContextIdentifier"
    }
    
    override var textInputMode: UITextInputMode? {
        .activeInputModes.first(where: { $0.primaryLanguage == "emoji" })
    }
}
