//
//  TrackerEmptyStateView.swift
//  Reeach
//
//  Created by Balqis on 10/11/22.
//

import UIKit

class TrackerEmptyStateView: UIView {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Cashflow Tracker"
        lbl.font = .largeTitle
        lbl.textColor = .darkSlateGrey
        return lbl
    }()

    let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "IllustrationCashflow")
        return img
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Coming Soon, Gaes!"
        lbl.font = .bodyMedium
        lbl.textColor = .black7
        return lbl
    }()
    
    func configureAutoLayout() {
        self.backgroundColor = .whiteSmoke
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.anchor(top: topAnchor, paddingTop: UIScreen.main.bounds.height/12)
        
        addSubview(image)
        image.centerX(inView: self)
        image.anchor(top: titleLabel.topAnchor, paddingTop: UIScreen.main.bounds.height/6, width: 300, height: 280)
        
        addSubview(descLabel)
        descLabel.centerX(inView: self)
        descLabel.anchor(top: image.topAnchor, paddingTop: 300)
    }


}
