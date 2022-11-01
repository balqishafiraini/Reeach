//
//  GoalModalViewController.swift
//  Reeach
//
//  Created by Balqis on 26/10/22.
//

import UIKit

class GoalModalViewController: UIViewController {
    
    func configureStackView() {
        
        let cancelButton: UIButton = {
            let button = UIButton()
            button.setTitle("Batal", for: .normal)
            button.setTitleColor(UIColor.crimson, for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .left
            return button
        }()
        
        let addGoal: UILabel = {
            let label = UILabel()
            label.text = "Tambah Goal"
            label.font = .bodyBold
            return label
        }()
        
        let saveButton: UIButton = {
            let button = UIButton()
            button.setTitle("Simpan", for: .normal)
            button.setTitleColor(UIColor.royalHunterBlue, for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .right
            return button
        }()
        
        let icon: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.frame.size = CGSize(width: 200, height: 200)
            button.backgroundColor = UIColor(named: "secondary2")
            button.setTitle("Tambah Icon", for: .normal)
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.layer.cornerRadius = button.frame.height/2
            button.layer.masksToBounds = true
            return button
        }()
        
        let editIcon: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.frame.size = CGSize(width: 200, height: 200)
            button.backgroundColor = UIColor(named: "secondary2")
            button.setTitle("Tambah Icon", for: .normal)
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.layer.cornerRadius = button.frame.height/2
            button.layer.masksToBounds = true
            return button
        }()
        
        //        let editIcon = Button(style: .circle, foreground: .secondary, background: .tangelo, image: UIImage(named: "pencil"))
        
        let goalName = TextField(frame: .zero, title: "Judul Goal", style: .template)
        
        
        let recommendButton: UIButton = {
            let button = UIButton()
            button.setTitle("Bingung, guys? Lihat rekomendasinya di sini, kuy!", for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.titleLabel?.font = .caption1Bold
            button.titleLabel?.textAlignment = .left
            return button
        }()

        
        let dueDate = DatePicker(frame: .zero, title: "Deadline")
        
        let inflationButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
            button.setTitle("WATCH OUT! Nilai setelah inflasi: ", for: .normal)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
            button.setTitleColor(.royalHunterBlue, for: .normal)
            button.titleLabel?.font = .caption1Bold
            button.titleLabel?.textAlignment = .left
            return button
        }()
        
        let total = TextField(frame: .zero, title: "Jumlah", style: .template)
        
        let savingAmount = Toggle()
        
        let hstack = UIStackView(arrangedSubviews: [cancelButton, addGoal, saveButton])
        hstack.frame = view.bounds
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.spacing = 20
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        let vstack = UIStackView(arrangedSubviews: [hstack, icon, goalName, recommendButton, dueDate, total, inflationButton, savingAmount])
        vstack.frame = view.bounds
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.spacing = 20
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(vstack)
        
        vstack.backgroundColor = .white
        
        hstack.anchor(top:view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12,paddingLeft: 20, paddingRight: 20)
        
        vstack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        icon.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 95, paddingRight: 95, width: 200, height: 200)
        
        goalName.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingTop: 200, paddingLeft: 20, paddingRight: 20)
        
        recommendButton.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        dueDate.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        total.anchor(top: dueDate.topAnchor, left: vstack.leftAnchor, right: vstack.rightAnchor, paddingTop: 80, paddingLeft: 20, paddingRight: 20)
        
        inflationButton.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStackView()
    }
}



public extension UIImage {
  convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}
