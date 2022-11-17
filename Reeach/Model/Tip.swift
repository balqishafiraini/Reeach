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
            description: "Pelajari lebih lanjut soal S.M.A.R.T. goals di sini.",
            explanationHeader: "Apa fungsi S.M.A.R.T. Goal?",
            explanationDetail: """
                S.M.A.R.T. merupakan singkatan dari specific, measurable, achievable, relevant, dan time-bounded atau spesifik, dapat diukur, dapat dicapai, relevan, dan terkait waktu.
                
                Metode S.M.A.R.T. dapat membantumu membuat goals yang lebih realistis dan terukur. Tidak hanya itu, metode ini juga bisa menjadi panduan kamu dalam menyusun strategi untuk mencapai goals kamu.
                
                """
        ),
        Tip(
            id: 2,
            title: "Tipe Goals",
            description: "Yuk, kenali tipe financial goals!",
            explanationHeader: "Tentang Tipe Goal",
            explanationDetail: """
                Terdapat tiga tipe goal yang perlu kamu ketahui. Mengetahui tipe goal yang sesuai dapat membantu kamu membuat strategi dan perencanaan keuangan yang lebih efektif.
                
                Berikut adalah tiga tipe goal yang perlu kamu ketahui:  
                • Short-term goals: Goals yang ingin kamu capai dalam waktu kurang dari 3 tahun.
                • Medium-term goals: Goals yang ingin kamu capai dalam waktu 3-10 tahun.
                • Long-term goals: Goals yang ingin kamu capai lebih dari 10-tahun.
                
                """
        )
    ]
}
