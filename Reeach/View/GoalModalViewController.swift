//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

class GoalModalViewController: UIViewController {
    
    let icon = Button(style: .circle, foreground: .secondary, background: .royalHunterBlue, title: "Tambah icon")
    let goalName = TextField(frame: .zero, title: "Judul Goal", style: .template)
    let dueDate = DatePicker(frame: .zero)
    let total = TextField(frame: .zero, title: "Jumlah", style: .template)
    let savingAmount = Toggle()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
