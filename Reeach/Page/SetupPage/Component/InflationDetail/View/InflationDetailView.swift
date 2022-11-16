//
//  InflationDetailView.swift
//  Reeach
//
//  Created by William Chrisandy on 31/10/22.
//

import UIKit

class InflationDetailView: UIView {
    
    weak var viewController: InflationDetailViewController?
    weak var navigationBarDelegate: NavigationBarDelegate?
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return UIScrollView()
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private var imageViewContainerView = UIView()
        
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "IllustrationInflasi")
        return imageView
    }()
    
    lazy var whatLabel = {
        let label = UILabel()
        label.text = "Apa itu inflasi?"
        label.font = UIFont.bodyBold
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var whatDetailLabel = {
        let label = UILabel()
        label.text = """
            Diambil dari definisi Bank Indonesia, inflasi adalah proses kenaikan harga barang secara terus menerus dalam jangka waktu tertentu.
            
            Artinya, harga barang di tahun sekarang akan naik di tahun yang akan mendatang, ygy.
            
            """
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var howLabel = {
        let label = UILabel()
        label.text = "Kenapa penting tahu soal inflasi?"
        label.font = UIFont.bodyBold
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var howDetailLabel = {
        let label = UILabel()
        label.text = """
            Ini penting supaya kamu bisa tahu lebih tepat berapa banyak uang yang harus kamu siapkan untuk kebutuhan tertentu.
            
            """
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var whereLabel = {
        let label = UILabel()
        label.text = "Dari mana angka 4%?"
        label.font = UIFont.bodyBold
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var whereDetailLabel = {
        let label = UILabel()
        label.text = """
            Reeach menggunakan data dari World Bank untuk tahu angka ajaib ini. Angka ini diperbarui setiap tahunnya. Nah, 4% yang kita liat ini tuh data inflasi tahun 2022, bestie.
            
            """
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thenLabel = {
        let label = UILabel()
        label.text = "Terus, apa implikasinya?"
        label.font = UIFont.bodyBold
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thenDetailLabel = {
        let label = UILabel()
        label.text = """
            Ceritanya harga yang kamu masukin tahun ini tuh bakalan naik 4% di tahun depan. Nah, tahun depannya naik 4% lagi dari tahun sebelumnya, dan seterusnya. Jadi, harga yang kamu lihat itu adalah jumlah uang yang udah dipengaruhi faktor inflasi 4%.
            
            """
        label.numberOfLines = 0
        label.font = UIFont.bodyMedium
        label.textColor = .darkSlateGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: self, action: #selector(back(_:)))
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.royalHunterBlue as Any,
            NSAttributedString.Key.font: UIFont.bodyMedium as Any
        ]
        
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        
        return barButtonItem
    }()
    
    func configureView(viewController: InflationDetailViewController) {
        self.viewController = viewController
        backgroundColor = .ghostWhite
        
        configureNavigationControllerView()
        configureAutoLayout()
    }
    
    func configureNavigationControllerView() {
        navigationBarDelegate = viewController
        viewController?.navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureAutoLayout() {
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, paddingLeft: 20)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        stackView.addArrangedSubview(imageViewContainerView)
        imageViewContainerView.addSubview(imageView)
        imageView.center(inView: imageViewContainerView)
        imageViewContainerView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        
        stackView.addArrangedSubview(whatLabel)
        stackView.addArrangedSubview(whatDetailLabel)
        stackView.addArrangedSubview(howLabel)
        stackView.addArrangedSubview(howDetailLabel)
        stackView.addArrangedSubview(whereLabel)
        stackView.addArrangedSubview(whereDetailLabel)
        stackView.addArrangedSubview(thenLabel)
        stackView.addArrangedSubview(thenDetailLabel)
    }
    
    func configureText(inflationRate: Double, inflationYear: Double) {
        let inflationRateString = DoubleToStringHelper.roundUpToString(double: inflationRate)
        let inflationYearString = "\(Int(inflationYear))"
        whereLabel.text = "Dari mana angka \(inflationRateString)%?"
        whereDetailLabel.text = """
            Reeach menggunakan data dari World Bank untuk tahu angka ajaib ini. Angka ini diperbarui setiap tahunnya. Nah, \(inflationRateString)% yang kita liat ini tuh data inflasi tahun \(inflationYearString), bestie.
            
            """
        thenDetailLabel.text = """
            Ceritanya harga yang kamu masukin tahun ini tuh bakalan naik \(inflationRateString)% di tahun depan. Nah, tahun depannya naik \(inflationRateString)% lagi dari tahun sebelumnya, dan seterusnya. Jadi, harga yang kamu lihat itu adalah jumlah uang yang udah dipengaruhi faktor inflasi \(inflationRateString)%.
            
            """
    }
    
    @objc func back(_ animated: Bool) {
        navigationBarDelegate?.cancel()
    }
}
