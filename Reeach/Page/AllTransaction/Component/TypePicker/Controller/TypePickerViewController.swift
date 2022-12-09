//
//  TypePickerViewController.swift
//  Reeach
//
//  Created by James Christian Wira on 02/12/22.
//

import UIKit

class TypePickerViewController: UIViewController {

    lazy var typePickerView = TypePickerView()
    
    weak var delegate: FilterDelegate?
    
    static let identifier = "typePickerViewControllerIdentifier"
    
    let types = ["Goal", "Pengeluaran", "Pemasukan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = typePickerView
        self.title = "Pilih Jenis Transaksi"
        
        typePickerView.collectionView.delegate = self
        typePickerView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        typePickerView.setupView()
    }
}

extension TypePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionViewCell.identifier, for: indexPath) as! FilterItemCollectionViewCell
        
        cell.setupData(label: types[indexPath.item])
        cell.setupView()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selected(selectedItem: types[indexPath.item])
        navigationController?.popViewController(animated: true)
    }
}
