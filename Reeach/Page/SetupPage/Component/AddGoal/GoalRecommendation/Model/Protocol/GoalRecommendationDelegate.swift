//
//  GoalRecommendationDelegate.swift
//  Reeach
//
//  Created by William Chrisandy on 16/11/22.
//

import Foundation

protocol GoalRecommendationViewControllerDelegate: AnyObject {
    func selected(recommendation: Goal.Recommendation)
}
