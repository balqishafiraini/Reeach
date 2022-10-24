//
//  Checkbox.swift
//  Reeach
//
//  Created by Balqis on 22/10/22.
//

import Foundation
import UIKit

class Checkbox: UIView {
    
    var isChecked = false
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .royalHunterBlue
        return imageView
    }()
    
    let boxView: UIView = {
       let box = UIView()
        box.layer.borderWidth = 0.5
        box.layer.borderColor = UIColor.royalHunterBlue?.cgColor
        box.layer.cornerRadius = 12
        box.backgroundColor = UIColor(named: "secondary1")
        return box
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        addSubview(boxView)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //designable
//        boxView.frame = = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
//        imageView.frame = bounds
    }
    
    public func toggle() {
        self.isChecked = !isChecked
        
        imageView.isHidden = !isChecked
    }
}
