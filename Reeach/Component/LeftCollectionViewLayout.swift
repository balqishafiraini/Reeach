//
//  LeftCollectionViewLayout.swift
//  Reeach
//
//  Created by James Christian Wira on 09/12/22.
//

import UIKit

class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 12.0
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                return
            }
            
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
