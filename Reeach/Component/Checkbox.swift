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
    var desc: String?
    var title: String
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .bodyMedium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setDesc(desc: String) {
        descLabel.text = desc
    }
    
    init (title: String, desc: String) {
        self.title = title
        self.desc = desc
        super.init(frame: .zero)
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
