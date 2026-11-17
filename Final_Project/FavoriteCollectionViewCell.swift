//
//  FavoriteCollectionViewCell.swift
//  Final_Project
//
//  Created by Koonladar yannakonchomchan on 17/11/2569 BE.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var posterImageView: UIImageView!
        @IBOutlet weak var categoryBadgeLabel: UILabel!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var ratingLabel: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            posterImageView.layer.cornerRadius = 12
            posterImageView.clipsToBounds = true
            
            categoryBadgeLabel.layer.cornerRadius = 6
            categoryBadgeLabel.clipsToBounds = true
        }
        
        func configure(with item: ProfileViewController.FavoriteItem) {
            titleLabel.text = item.title
            categoryBadgeLabel.text = " \(item.category) "
            ratingLabel.text = "★ \(item.rating)"
            
            // โหลดรูปจาก Assets (หากยังไม่มีรูปให้ใส่สีพื้นหลังสำรองไว้)
            if let image = UIImage(named: item.posterImageName) {
                posterImageView.image = image
            } else {
                posterImageView.backgroundColor = .systemGray4
            }
        }
    }
}
