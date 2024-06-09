//
//  SliderImageTVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit

class SliderImageTVC: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRegisterNow: UIButton!
    
    private var images:[String] = []
   
    
    func configure(car: Car?){
        self.images = car?.images ?? []
        lblPrice.text = "\(car?.grossPrice ?? 0) \(car?.currency ?? "")"
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "SliderImageCVC", bundle: nil), forCellWithReuseIdentifier: "SliderImageCVC")
        self.collectionView.reloadData()
        if K_Defaults.string(forKey: Saved.TOKEN) != nil {
            btnRegisterNow.isHidden = true
        } else {
            lblPrice.isHidden = true
            btnRegisterNow.isHidden = false
        }
        
    }
    
    @IBAction func RegisterNow(_ sender: UIButton){
        let registerVC = RegisterVC()
        registerVC.modalPresentationStyle = .fullScreen
        self.parentViewController?.present(registerVC, animated: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderImageCVC", for: indexPath) as? SliderImageCVC else{return UICollectionViewCell()}
        cell.configure(images: self.images)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: self.contentView.frame.width , height: 237)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
