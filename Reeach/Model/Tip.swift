//
//  Tip.swift
//  Reeach
//
//  Created by William Chrisandy on 14/11/22.
//

import UIKit

class Tip {
    let id: Int64
    let title: String
    let description: String
    let coverImage: UIImage
    let image: UIImage
    let explanationHeader: String
    let explanationDetail: String
    
    init(id: Int64, title: String, description: String, explanationHeader: String, explanationDetail: String) {
        self.id = id
        self.title = title
        self.description = description
        self.explanationHeader = explanationHeader
        self.explanationDetail = explanationDetail
        coverImage = UIImage(named: "IllustrationTips\(id)Cover")!
        image = UIImage(named: "IllustrationTips\(id)")!
    }
    
    static let allTips = [
        Tip(
            id: 1,
            title: "S.M.A.R.T. Goals",
            description: "Punya financial goals yang S.M.A.R.T bisa bantu kamu lebih stay on-track loh. Yuk lihat risetnya!",
            explanationHeader: "SMART Goal",
            explanationDetail: """
                Penjelasan tentang SMART Goal
                """
        ),
        Tip(
            id: 2,
            title: "Tipe Goals",
            description: "Kamu disarankan membagi goalsmu jadi tiga tipe, short, medium, dan long term. Apa saja goalsnya?",
            explanationHeader: "Tentang Tipe Goal",
            explanationDetail: """
                Penjelasan tentang tipe goal
                """
        )
    ]
}
