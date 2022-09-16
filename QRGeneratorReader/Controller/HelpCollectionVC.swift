//
//  HelpCollectionVC.swift
//  QRGeneratorReader
//
//  Created by Arip Khozhbanov on 16.09.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class HelpCollectionVC: UICollectionViewController {
    
    let photos = [ "qr1-1" , "qr2-1" , "qr3" , "qr4" , "qr5" , "qr6" , "qr7" , "qr8" , "qr9" , "qr10" , "qr11" , "qr12" , "qr13" , "qr14" , "qr16" , "qr17" , "qr18" , "qr19" , "qr20" , "qr21" , "qr22" , "qr23" , "qr24" , "qr25" , "qr26" , "qr27" , "qr28" , "qr29"]
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! HelpCollectionViewCell
        
        let imageName = photos[indexPath.item]
        let image = UIImage(named: imageName)
        
        cell.imaga.image = image
    
        return cell
    }

}


// MARK: - UICollectionViewDelegateFlowLayout
extension HelpCollectionVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
